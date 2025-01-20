import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {
  String? barcode;
  int count =  0;
  MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      if(barcodes.barcodes.firstOrNull!.displayValue != null){

        setState(() {
          barcode = barcodes.barcodes.firstOrNull!.displayValue;
          if(count == 0){
            count++;
            Navigator.pop(context, barcode);
          }

        });
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                controller: controller,
                fit: BoxFit.contain,
                onDetect:_handleBarcode
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: controller,
                          builder: (context, state, child) {
                            if (!state.isInitialized || !state.isRunning) {
                              return const SizedBox.shrink();
                            }

                            switch (state.torchState) {
                              case TorchState.auto:
                                return IconButton(
                                  color: Colors.white,
                                  iconSize: 32.0,
                                  icon: const Icon(Icons.flash_auto),
                                  onPressed: () async {
                                    await controller.toggleTorch();
                                  },
                                );
                              case TorchState.off:
                                return IconButton(
                                  color: Colors.white,
                                  iconSize: 32.0,
                                  icon: const Icon(Icons.flash_off),
                                  onPressed: () async {
                                    await controller.toggleTorch();
                                  },
                                );
                              case TorchState.on:
                                return IconButton(
                                  color: Colors.white,
                                  iconSize: 32.0,
                                  icon: const Icon(Icons.flash_on),
                                  onPressed: () async {
                                    await controller.toggleTorch();
                                  },
                                );
                              case TorchState.unavailable:
                                return const SizedBox.square(
                                  dimension: 48.0,
                                  child: Icon(
                                    Icons.no_flash,
                                    size: 32.0,
                                    color: Colors.grey,
                                  ),
                                );
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => controller.toggleTorch(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
