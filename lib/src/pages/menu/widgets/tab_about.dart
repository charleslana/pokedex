import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TabAbout extends StatelessWidget {
  const TabAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('menuAboutDescription'.tr),
            const SizedBox(
              height: 10,
            ),
            Text('menuAboutSpecialThanks'.tr),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Text('Bruno Silva'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Charles Lana'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Flavio Adriano'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Izabelle Nascimento'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('João Vitor'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Matheus Gomes'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Vinicius Lopes'),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
