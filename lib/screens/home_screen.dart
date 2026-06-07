import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../config/app_config.dart';
import '../services/radio_service.dart';
import '../widgets/audio_wave.dart';
import '../widgets/social_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final RadioService radio = RadioService();

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    radio.initialize();
  }

  Future<void> playRadio() async {
    try {
      setState(() => isPlaying = true);

      await radio.play(AppConfig.streamUrl);

    } catch (e) {
      setState(() => isPlaying = false);
      debugPrint("ERROR PLAY: $e");
    }
  }

  Future<void> pauseRadio() async {
    try {
      await radio.pause();
      setState(() => isPlaying = false);
    } catch (e) {
      debugPrint("ERROR PAUSE: $e");
    }
  }

  @override
  void dispose() {
    radio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [

          /// Fondo
          Image.asset(
            "assets/images/background.jpg",
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: Colors.black),
          ),

          /// Overlay
          Container(
            color: Colors.black.withOpacity(0.35),
          ),

          SafeArea(
            child: Column(
              children: [

                const SizedBox(height: 10),

                _buildHeader(),

                const Spacer(),

                _buildCenter(),

                const SizedBox(height: 25),

                _buildPlayerButton(),

                const Spacer(),

                _buildSocialButtons(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Image.asset("assets/images/logo.png", width: 40),

          const Spacer(),

          Column(
            children: const [
              Text(
                "Zion Radio",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "EN VIVO",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const Spacer(),

          IconButton(
            onPressed: () {
              Share.share("Escucha Zion Radio en https://zionradio.es");
            },
            icon: const Icon(Icons.share, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildCenter() {
    return Column(
      children: [

        Image.asset("assets/images/logo.png", width: 120),
        const SizedBox(height: 20),

        Image.asset("assets/images/nombre.png", width: 280),
        const SizedBox(height: 12),

        Image.asset("assets/images/lema.png", width: 220),

        const SizedBox(height: 25),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.redAccent),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, color: Colors.red, size: 12),
              SizedBox(width: 8),
              Text(
                "EN VIVO",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        if (isPlaying) const AudioWave(),
      ],
    );
  }

  Widget _buildPlayerButton() {
    return GestureDetector(
      onTap: isPlaying ? pauseRadio : playRadio,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Image.asset(
          isPlaying
              ? "assets/images/pause.png"
              : "assets/images/play.png",
          key: ValueKey(isPlaying),
          width: 140,
          height: 140,
        ),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SocialButton(icon: "assets/icons/icoweb.png", url: AppConfig.website),
          SocialButton(icon: "assets/icons/icoface.png", url: AppConfig.facebook),
          SocialButton(icon: "assets/icons/icoinst.png", url: AppConfig.instagram),
          SocialButton(icon: "assets/icons/icoyou.png", url: AppConfig.youtube),
          SocialButton(icon: "assets/icons/icotic.png", url: AppConfig.tiktok),
        ],
      ),
    );
  }
}