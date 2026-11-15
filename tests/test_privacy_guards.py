from pathlib import Path
import unittest
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]


class PrivacyGuards(unittest.TestCase):
    def test_no_permissions_or_services(self):
        manifest = ET.parse(ROOT / 'AndroidManifest.xml').getroot()
        self.assertEqual(manifest.findall('uses-permission'), [])
        self.assertEqual(manifest.findall('.//service'), [])
        name = '{http://schemas.android.com/apk/res/android}name'
        self.assertEqual({p.attrib[name] for p in manifest.findall('queries/package')},
                         {'io.gh.akshat.tizentube.cobalt', 'io.gh.reisxd.tizentube.cobalt'})

    def test_preferred_player_and_no_remote_key_handling(self):
        source = (ROOT / 'src/io/akshat/youtube/shortcut/LaunchActivity.java').read_text()
        self.assertLess(source.index('io.gh.akshat.tizentube.cobalt'), source.index('io.gh.reisxd.tizentube.cobalt'))
        for forbidden in ['dispatchKeyEvent', 'onKeyDown', 'AccessibilityService', 'Runtime.getRuntime', 'ProcessBuilder']:
            self.assertNotIn(forbidden, source)

    def test_public_build_uses_only_original_vectors_and_external_signing(self):
        self.assertEqual(list((ROOT / 'resources').rglob('*.png')), [])
        build = (ROOT / 'build.sh').read_text()
        self.assertIn('env:KEYSTORE_PASSWORD', build)
        self.assertNotIn('--ks-pass pass:', build)
        self.assertNotIn('adb ', build)


if __name__ == '__main__':
    unittest.main()
