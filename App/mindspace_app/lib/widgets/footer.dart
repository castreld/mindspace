import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: const Color.fromARGB(255, 101, 58, 80),
      child: const Wrap(
        spacing: 200,
        runSpacing: 40,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          FooterColumn(
            title: "Ikuti Kami",
            links: {
              "@mindspace.smkn1cmi": "#",
              "Mindspace SMKN 1 Cimahi": "#",
              "LinkedIn": "#",
            },
          ),
          FooterColumn(
            title: "Fungsi",
            links: {
              "Desain UI": "#",
              "Wireframing": "#",
              "Brainstorming": "#",
            },
          ),
          FooterColumn(
            title: "Jelajahi",
            links: {
              "Desain": "#",
              "Prototipe": "#",
              "Fitur Pengembangan": "#",
            },
          ),
          FooterColumn(
            title: "Dukungan",
            links: {
              "Pusat Bantuan": "#",
              "Kebijakan Privasi": "#",
              "Syarat Layanan": "#",
            },
          ),
        ],
      ),
    );
  }
}

class FooterColumn extends StatelessWidget {
  final String title;
  final Map<String, String> links;

  const FooterColumn({super.key, required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 30),
        ...links.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextButton(
              onPressed: () {
                // TODO: Handle link tap
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
              child: Text(
                entry.key,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          );
        }),
      ],
    );
  }
}