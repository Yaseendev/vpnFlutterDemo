import 'package:flutter/material.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final OpenVPN openvpn;
  VpnStatus? status;
  VPNStage? stage;

  @override
  void initState() {
    _initVPN();
    super.initState();
  }

  void _initVPN() async {
    openvpn = OpenVPN(
      onVpnStatusChanged: _onVpnStatusChanged,
      onVpnStageChanged: _onVpnStageChanged,
    );
    await openvpn.initialize(

        ///Example 'group.com.laskarmedia.vpn'
        groupIdentifier: "group.com.fortify.vpnDemo",

        ///Example 'id.laskarmedia.openvpnFlutterExample.VPNExtension'
        providerBundleIdentifier: "com.fortify.vpnDemo.VPNExtension",
        localizedDescription: "Fortify Test");
  }

  void _onVpnStatusChanged(VpnStatus? vpnStatus) {
    setState(() {
      status = vpnStatus;
    });
  }

  void _onVpnStageChanged(VPNStage? vpnStage, s) {
    setState(() {
      stage = vpnStage;
    });
  }

  static const String config = '''client
dev tun
proto tcp
remote 65.108.57.70 35403
remote-random
push-peer-info
ping 10
#ping-exit 10
ping-restart 10
mute 3
resolv-retry 2
nobind
persist-tun
verb 3
auth-user-pass
auth-nocache
remote-cert-tls server
cipher AES-256-CBC
auth SHA512
setenv opt block-outside-dns
connect-timeout 10
hand-window 30
reneg-sec 0
nobind
connect-retry-max 1
connect-retry 2 300
<ca>
-----BEGIN CERTIFICATE-----
MIIDSDCCAjCgAwIBAgIUDeLZzrOifd8K57/1D6EX0xBsZ8AwDQYJKoZIhvcNAQEL
BQAwFTETMBEGA1UEAwwKRm9ydGlmeVZQTjAeFw0yNDAxMDkyMzMyMzJaFw0zNDAx
MDYyMzMyMzJaMBUxEzARBgNVBAMMCkZvcnRpZnlWUE4wggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQC1PN6wqklAmT+IxYJXBlhKp0w6cSO98iZj4D9jW1qu
zncJ4bAEfNYD9JlcY5GfqGMhc8N2Li3RbG6GeSBDazO5xWG0e+9GCMoyiiNZecbE
rW6aUXbagLtvlUNl87Bwl/Rjcfdm0a8lXhqzv+McHFjw6WNoBm5yBH3gtPmTGxFd
0p19NVxuiIlbComzUmdPWCKI+xbgh9ZuTE17fywrHi5C8RqrZkaO54i0ficbloiP
n9gHtnMAKv3s2CcLQH4kavIIVZLNHb2adV1ofbpRW4/lYoAwZnGDvmii5jf/kzUK
4cwPUcjchA2F6DMpRq8MSYc8QjFKQ4+isfGEHw0kEVMRAgMBAAGjgY8wgYwwHQYD
VR0OBBYEFOhHi/iSJCSkGHAYZivGjOL6d2+DMFAGA1UdIwRJMEeAFOhHi/iSJCSk
GHAYZivGjOL6d2+DoRmkFzAVMRMwEQYDVQQDDApGb3J0aWZ5VlBOghQN4tnOs6J9
3wrnv/UPoRfTEGxnwDAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIBBjANBgkqhkiG
9w0BAQsFAAOCAQEAX1GEVDhHFcEy4WlGu9qAYP4LuEZON/4k+kzJ4TAhmls2dYgd
8BVHBTRMkzJRmE5OE/Ofn4uhiz4fTGEVdUFC1OCg89MCPUTOzLV7+p2OZN5sXcxD
sUs3+sdiUnjt8e85+kWcSx3Gb6FohxwcMWPnvzuWmJr/Jt7eZVTz79520ZjnGAT0
l+eQ4mA8DYzkYnU7roBVrur/e7bKmt4xvwTfBhf+3eXZXgK3L5hbjiURb0Q73Swx
FwQ6qykXZm2KAGj2yKp3eWlpCaU/29q1OhVwBwhdA5FOzY3xRxl4Ik7K9SS4VTse
4Lu0fuhPlXcb6e75IV/hx9CSBgsiGd4cZzgsfg==
-----END CERTIFICATE-----
</ca>
<tls-crypt>
#
# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
4583d19e82e196b599a11e739b0c2d47
91bf1c021e06de8d2fd790080955e52a
e2d80b7f9b1f69bf364d09a15a9caa14
4b3ba1dd5ee481bc5819f6a65b880cd9
c4c820f9c9cc13b33e08a2d2a5a6463d
e43564767a981bd32e6488094a132302
cf0d3f522995efec644aa270151c5018
bb5912b908c165249ab900a1c99796aa
cca086e402f158922cbcc90e7c09d608
c3ec8eb535b2499623245aa00c927050
9c21bf0d3b74a8f4fe99166518d80e98
639dd7099f0765ef1a63cfa04dcb7693
65ba6ff6cd2a41222f73b7cdbe09f437
6f7f5d13c9dae715161e0811df181f6d
b883ee89ed7aca855bff1b481f511b96
e5f7e88b9a39f0071b996064444f41c2
-----END OpenVPN Static key V1-----
</tls-crypt>''';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(stage?.name ?? 'VPN Status'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (stage == VPNStage.disconnected ||
                stage == VPNStage.denied ||
                stage == VPNStage.error ||
                stage == VPNStage.unknown ||
                stage == null) {
              openvpn.connect(
                config,
                'Fortify_Test',
                username: '8xxrdh2b5@mzw2nefh.com',
                password: 'vqv11zyrhhi',
                certIsRequired: true,
              );
            } else if (stage == VPNStage.connected ||
                stage == VPNStage.connecting) {
              openvpn.disconnect();
            }
          },
          label: Text(stage == VPNStage.connected ? 'Disconnect' : 'Connect'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
