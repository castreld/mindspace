import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mindspace_app/models/appointment.dart';
import 'package:mindspace_app/services/booking_service.dart';
import 'package:mindspace_app/user/dashboard/widgets/therapist_notes_dialog.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HistoryDetailDialog extends StatefulWidget {
  final Appointment appointment;
  final VoidCallback onReviewSubmitted;
  final String currentUserRole;

  const HistoryDetailDialog({
    super.key,
    required this.appointment,
    required this.onReviewSubmitted,
    required this.currentUserRole,
  });

  @override
  State<HistoryDetailDialog> createState() => _HistoryDetailDialogState();
}

class _HistoryDetailDialogState extends State<HistoryDetailDialog> {
  final _reviewController = TextEditingController();
  double _rating = 0;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _rating = widget.appointment.rating?.toDouble() ?? 0;
    _reviewController.text = widget.appointment.reviewComment ?? '';
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_rating < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon berikan rating bintang (minimal 1).'), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await context.read<BookingService>().submitReview(
        appointmentId: widget.appointment.id,
        rating: _rating.toInt(),
        comment: _reviewController.text.trim(),
      );

      widget.onReviewSubmitted();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review berhasil dikirim!'), backgroundColor: Colors.green),
      );

    } on ApiException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengirim review: ${e.statusCode} ${e.body['message'] ?? e.body}'), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    bool isCompleted = widget.appointment.status == 'Selesai' || widget.appointment.status == 'completed';
    bool isClient = widget.currentUserRole == 'klien';
    bool hasReview = widget.appointment.rating != null;
    bool hasNotes = widget.appointment.therapistNotes != null && widget.appointment.therapistNotes!.isNotEmpty;

    String displayName = isClient
      ? widget.appointment.therapist?.fullName ?? 'Psikolog N/A'
      : widget.appointment.client?.fullName ?? 'Klien N/A';

    String nameLabel = isClient ? 'Psikolog' : 'Klien';
    IconData nameIcon = isClient ? Icons.support_agent : Icons.person_outline;

    String topicText = isClient
      ? 'Sesi Konseling'
      : widget.appointment.clientNotes ?? 'Tidak ada catatan klien';


    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Detail Konseling', textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            _buildDetailRow(nameIcon, nameLabel, displayName),
            _buildDetailRow(Icons.calendar_today_outlined, 'Waktu', DateFormat('EEEE, d MMM yyyy, HH:mm', 'id_ID').format(widget.appointment.appointmentTime)),
            _buildDetailRow(Icons.topic_outlined, isClient ? 'Topik' : 'Keluhan Klien', topicText),
            _buildDetailRow(Icons.info_outline, 'Status', widget.appointment.status.replaceAll('_', ' ').toUpperCase()),

            if (isCompleted && !isClient) ...[
              const Divider(height: 20),
              Text('Catatan Klien:', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 4),
              Container(
                  padding: const EdgeInsets.all(8),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Text(topicText),
              ),
            ],

            if (isCompleted && isClient && hasNotes) ...[
              const Divider(height: 20),
              Text('Catatan Psikolog:', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 4),
              Container(
                  padding: const EdgeInsets.all(8),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Text(widget.appointment.therapistNotes!),
              ),
            ],
            
            if (isCompleted) ...[
              const Divider(height: 30),
              if (isClient)
                _buildClientReviewSection(hasReview)
              else
                _buildTherapistNotesSection(hasNotes)
            ],
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton(
          child: const Text('Tutup'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        if (isCompleted && !hasReview && isClient)
          ElevatedButton(
            onPressed: _isSubmitting ? null : _submitReview,
            child: _isSubmitting
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Kirim Review'),
          ),
      ],
    );
  }

  Widget _buildClientReviewSection(bool hasReview) {
    return Column(
      children: [
        Text(hasReview ? 'Review Anda' : 'Berikan Review', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        Center(
          child: RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: hasReview ? (rating) {} : (rating) {
              setState(() {
                _rating = rating;
              });
            },
            ignoreGestures: hasReview,
          ),
        ),
        const SizedBox(height: 15),
        if (hasReview)
          Text(widget.appointment.reviewComment ?? 'Tidak ada komentar.')
        else
          TextField(
            controller: _reviewController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Tulis komentar Anda (opsional)...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTherapistNotesSection(bool hasNotes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hasNotes ? 'Catatan Sesi Anda' : 'Berikan Catatan Sesi', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 15),
        if (hasNotes)
          Container(
              padding: const EdgeInsets.all(8),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Text(widget.appointment.therapistNotes!),
            )
        else
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.note_add_outlined),
              label: const Text('Berikan Catatan'),
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => TherapistNotesDialog(
                    appointment: widget.appointment,
                    onNotesSubmitted: widget.onReviewSubmitted,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade700),
          const SizedBox(width: 10),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}