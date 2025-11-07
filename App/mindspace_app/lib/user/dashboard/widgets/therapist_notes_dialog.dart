import 'package:flutter/material.dart';
import 'package:mindspace_app/models/appointment.dart';
import 'package:mindspace_app/services/booking_service.dart';
import 'package:provider/provider.dart';

class TherapistNotesDialog extends StatefulWidget {
  final Appointment appointment;
  final VoidCallback onNotesSubmitted;

  const TherapistNotesDialog({
    super.key,
    required this.appointment,
    required this.onNotesSubmitted,
  });

  @override
  State<TherapistNotesDialog> createState() => _TherapistNotesDialogState();
}

class _TherapistNotesDialogState extends State<TherapistNotesDialog> {
  final _notesController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.appointment.therapistNotes ?? '';
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitNotes() async {
     final notes = _notesController.text.trim();
     if (notes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Catatan tidak boleh kosong.'), backgroundColor: Colors.orange),
        );
        return;
     }

     setState(() => _isSubmitting = true);

     try {
        await context.read<BookingService>().addTherapistNotes(
           appointmentId: widget.appointment.id,
           notes: notes,
        );

        widget.onNotesSubmitted();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Catatan berhasil disimpan!'), backgroundColor: Colors.green),
        );

     } on ApiException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Gagal menyimpan catatan: ${e.statusCode} ${e.body['message'] ?? e.body}'), backgroundColor: Colors.red),
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
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Catatan Sesi', textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
             Text('Klien: ${widget.appointment.client?.fullName ?? 'N/A'}'),
             Text('Waktu: ${widget.appointment.formattedDateTime}'),
             const SizedBox(height: 15),
             TextField(
               controller: _notesController,
               maxLines: 5,
               decoration: InputDecoration(
                 hintText: 'Masukkan catatan Anda mengenai sesi ini...',
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(8),
                 ),
               ),
             ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton(
          child: const Text('Batal'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitNotes,
          child: _isSubmitting
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Simpan Catatan'),
        ),
      ],
    );
  }
}