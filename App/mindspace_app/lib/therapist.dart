import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mindspace_app/animated_background.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/widgets/custom_app_bar.dart';
import 'package:mindspace_app/widgets/footer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';


class Therapist {
  final int id;
  final String name;
  final String? imageUrl;
  final double rating;
  final int hourlyRate;
  final int experienceYears;
  final List<String> specializations;

  Therapist({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.rating,
    required this.hourlyRate,
    required this.experienceYears,
    required this.specializations,
  });

  factory Therapist.fromJson(Map<String, dynamic> json) {
    
    List<String> parseSpecializations(dynamic specs) {
      if (specs is String) {
        try {
          final List<dynamic> decoded = jsonDecode(specs);
          return decoded.map((e) => e.toString()).toList();
        } catch (e) {
          return [];
        }
      } else if (specs is List) {
        return specs.map((e) => e.toString()).toList();
      }
      return [];
    }

    return Therapist(
      id: json['id'],
      name: json['full_name'] ?? 'Unknown Therapist',
      
      imageUrl: json['therapist_profile']?['profile_picture_path'] != null
          ? 'http://127.0.0.1:8000/api/${json['therapist_profile']['profile_picture_path']}'
          : null,
      
      rating: double.tryParse(json['reviews_avg_rating']?.toString() ?? '0.0') ?? 0.0,
      hourlyRate: json['therapist_profile']?['hourly_rate'] ?? 0,
      experienceYears: json['therapist_profile']?['experience_years'] ?? 0,
      specializations: parseSpecializations(json['therapist_profile']?['specializations']),
    );
  }
}

class TherapistPage extends StatefulWidget {
  final User user;
  final String token;
  const TherapistPage({super.key, required this.user, required this.token});

  @override
  State<TherapistPage> createState() => _TherapistPageState();
}

class _TherapistPageState extends State<TherapistPage> {
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      appBar: CustomAppBar(user: _currentUser),
      drawer: const _AppDrawer(),
      body: Stack(
        children: [
          const AnimatedGradientBackground(),
          CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: TherapistSection(),
              ),
              if (kIsWeb) const FooterSection(),
            ],
          )
        ],
      ),
    );
  }
}

class TherapistSection extends StatefulWidget {
  const TherapistSection({super.key});

  @override
  State<TherapistSection> createState() => _TherapistSectionState();
}

class _TherapistSectionState extends State<TherapistSection> {
  
  List<Therapist> _therapists = [];
  bool _isLoading = true;
  String? _error;

  
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  
  final Map<String, dynamic> _filters = {};
  
  
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchTherapists();
    
    
    _searchController.addListener(_onSearchChanged);
    _minPriceController.addListener(_onPriceChanged);
    _maxPriceController.addListener(_onPriceChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  
  Future<void> _fetchTherapists() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      
      final uri = Uri.parse('http://127.0.0.1:8000/api/therapists').replace(
        queryParameters: _filters.map((key, value) => MapEntry(key, value.toString())),
      );

      final response = await http.get(uri, headers: {'Accept': 'application/json'});
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> therapistData = responseData['data']; 
        
        setState(() {
          _therapists = therapistData.map((data) => Therapist.fromJson(data)).toList();
        });
      } else {
        throw Exception('Failed to load therapists');
      }
    } catch (e) {
      setState(() {
        _error = "Error: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
       _updateFilter('search', _searchController.text);
    });
  }

  void _onPriceChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
       _updateFilter('min_price', _minPriceController.text);
       _updateFilter('max_price', _maxPriceController.text);
    });
  }

  
  void _updateFilter(String key, dynamic value) {
    setState(() {
      if (value == null || (value is String && value.isEmpty) || (value is bool && !value)) {
        _filters.remove(key);
      } else {
        _filters[key] = value;
      }
    });
    _fetchTherapists();
  }

  
  void _updateCheckboxListFilter(String key, String value, bool isChecked) {
    
    final List<String> currentList = _filters[key]?.toString().split(',') ?? [];
    
    if (isChecked) {
      if (!currentList.contains(value)) {
        currentList.add(value);
      }
    } else {
      currentList.remove(value);
    }
    
    _updateFilter(key, currentList.isNotEmpty ? currentList.join(',') : null);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 800;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isDesktop)
                Expanded(
                  flex: 2,
                  child: FilterSidebar(
                    
                    minPriceController: _minPriceController,
                    maxPriceController: _maxPriceController,
                    onCheckboxChanged: _updateCheckboxListFilter,
                    onFilterChanged: _updateFilter,
                  ),
                ),
              if (isDesktop) const SizedBox(width: 24),
              Expanded(
                flex: 5,
                child: TherapistContent(
                  therapists: _therapists, 
                  isLoading: _isLoading,
                  error: _error,
                  searchController: _searchController,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FilterSidebar extends StatelessWidget {
  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;
  final Function(String, String, bool) onCheckboxChanged;
  final Function(String, dynamic) onFilterChanged;

  const FilterSidebar({
    super.key,
    required this.minPriceController,
    required this.maxPriceController,
    required this.onCheckboxChanged,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFFFF8F0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const Text('Filter', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _FilterGroup(
              title: 'Kategori Terapis',
              children: [
                _CheckboxFilterItem(
                    title: 'Klinis Dewasa',
                    onChanged: (isChecked) => onCheckboxChanged('specializations', 'Klinis Dewasa', isChecked)),
                _CheckboxFilterItem(
                    title: 'Klinis Anak dan Remaja',
                    onChanged: (isChecked) => onCheckboxChanged('specializations', 'Klinis Anak dan Remaja', isChecked)),
                _CheckboxFilterItem(
                    title: 'Klinis Pendidikan',
                    onChanged: (isChecked) => onCheckboxChanged('specializations', 'Klinis Pendidikan', isChecked)),
              ],
            ),
            _FilterGroup(
              title: 'Harga',
              children: [
                TextField(
                  controller: minPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: 'Rp ', labelText: 'Harga Minimum', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: maxPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: 'Rp ', labelText: 'Harga Maksimum', border: OutlineInputBorder()),
                ),
              ],
            ),
            _FilterGroup(
              title: 'Gender',
              children: [
                _CheckboxFilterItem(title: 'Pria', onChanged: (isChecked) => onFilterChanged('gender', isChecked ? 'pria' : null)),
                _CheckboxFilterItem(title: 'Wanita', onChanged: (isChecked) => onFilterChanged('gender', isChecked ? 'wanita' : null)),
              ],
            ),
             _FilterGroup(
              title: 'Jadwal',
              children: [
                _CheckboxFilterItem(title: 'Tersedia', onChanged: (isChecked) => onFilterChanged('is_available', isChecked ? 'true' : null)),
              ],
            ),
            _FilterGroup(
              title: 'Rating',
              children: [
                _CheckboxFilterItem(title: 'Rating 4 ke atas', onChanged: (isChecked) => onFilterChanged('min_rating', isChecked ? '4' : null)),
              ],
            ),
            _FilterGroup(
              title: 'Lainnya',
              children: [
                _CheckboxFilterItem(title: 'Pengalaman 5 Tahun Ke Atas', onChanged: (isChecked) => onFilterChanged('min_experience', isChecked ? '5' : null)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _FilterGroup({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      initiallyExpanded: true,
      childrenPadding: const EdgeInsets.all(8.0),
      children: children,
    );
  }
}

class _CheckboxFilterItem extends StatefulWidget {
  final String title;
  final Function(bool) onChanged;
  const _CheckboxFilterItem({required this.title, required this.onChanged});

  @override
  State<_CheckboxFilterItem> createState() => _CheckboxFilterItemState();
}

class _CheckboxFilterItemState extends State<_CheckboxFilterItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: _isChecked,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value ?? false;
        });
        widget.onChanged(_isChecked);
      },
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }
}

class TherapistContent extends StatelessWidget {
  final List<Therapist> therapists;
  final bool isLoading;
  final String? error;
  final TextEditingController searchController;

  const TherapistContent({
    super.key,
    required this.therapists,
    required this.isLoading,
    this.error,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Cari Terapis berdasarkan nama...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else if (error != null)
          Center(child: Text(error!, style: const TextStyle(color: Colors.red)))
        else if (therapists.isEmpty)
          const Center(child: Text('Tidak ada terapis yang cocok dengan kriteria.'))
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: therapists.length,
            itemBuilder: (context, index) {
              return TherapistCard(therapist: therapists[index]);
            },
          ),
      ],
    );
  }
}

class TherapistCard extends StatelessWidget {
  final Therapist therapist;
  const TherapistCard({super.key, required this.therapist});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              
              child: therapist.imageUrl != null
                  ? Image.network(
                      therapist.imageUrl!, 
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.person, color: Colors.grey),
                        );
                      },
                    )
                  : Container( 
                      color: Colors.grey[300],
                      child: const Icon(Icons.person, color: Colors.grey),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            therapist.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(therapist.rating.toStringAsFixed(1)), 
            ],
          )
        ],
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF5B3F5B),
            ),
            child: Text(
              'Mindspace',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _DrawerItem('Home', Icons.home, () {
            Navigator.pushNamed(context, '/');
          }),
          _DrawerItem('Terapis', Icons.people, () {}),
          _DrawerItem('Jadwal', Icons.calendar_today, () {}),
          _DrawerItem('Kontak', Icons.contact_phone, () {}),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerItem(this.title, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      onTap: onTap,
    );
  }
}

