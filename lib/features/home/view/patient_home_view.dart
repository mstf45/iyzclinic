import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iyzclinic/core/utils/components/testfield/custom_text_from_field.dart';
import 'package:iyzclinic/core/utils/constants/custom_sized_box.dart';
import '../../../core/utils/components/material/custom_material.dart';
import '../../auth/view_model/auth_view_model.dart';
import '../../profile/view/profile_view.dart';
import 'package:provider/provider.dart';

class PatientHomeView extends StatelessWidget {
  const PatientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);
    return CustomMaterial(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hoş geldin kısmı
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "👋 Hoş geldin, ${vm.loggedName}",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => ProfileView()),
                      );
                    },
                    icon: Icon(Icons.person),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text("📅 Bugün: 29 Ekim 2025"),

              // Arama kutusu
              CustomSizedBoxHeight.large(),
              CustomTextFromField(
                prefixIcon: Icon(Icons.search),
                hint: "Doktor, klinik veya branş ara...",
              ),
              CustomSizedBoxHeight.large(),

              // Yaklaşan randevu
              Text(
                "🩺 Yaklaşan Randevun",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              CustomSizedBoxHeight.small(),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                elevation: 2,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/women/44.jpg",
                    ),
                    radius: 28,
                  ),
                  title: const Text("Dr. Ayşe Yılmaz - Kardiyoloji"),
                  subtitle: const Text("31 Ekim, 14:30  •  IYZClinic Ankara"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ),
              CustomSizedBoxHeight.large(),

              // Sık Görüştüğün Doktorlar
              Text(
                "❤️ Sık Görüştüğün Doktorlar",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              CustomSizedBoxHeight.small(),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(10, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Column(
                        spacing: 6,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/men/${index + 20}.jpg",
                            ),
                          ),
                          Text(
                            "Dr. Murat",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              CustomSizedBoxHeight.small(),

              // Sağlık Takibi
              Text(
                "📊 Sağlık Takibi",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              CustomSizedBoxHeight.medium(),
              Flex(
                direction: Axis.horizontal,
                spacing: 5,
                children: [
                  _healthCard("❤️ Nabız", "78 bpm", Icons.favorite),
                  _healthCard("💉 Tansiyon", "12.8", Icons.bloodtype),
                  _healthCard("🍬 Kan Şekeri", "98 mg/dL", Icons.monitor_heart),
                ],
              ),
              CustomSizedBoxHeight.large(),

              // Servisler
              Text(
                "🏥 Servisler",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _serviceButton("💊 Reçetelerim"),
                  _serviceButton("🧾 Geçmiş Randevularım"),
                  _serviceButton("📞 Acil Yardım"),
                  _serviceButton("💬 Destek & Canlı Chat"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _healthCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _serviceButton(String title) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        backgroundColor: Colors.deepPurple.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {},
      child: Expanded(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
