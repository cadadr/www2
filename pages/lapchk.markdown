title="ikinci el laptop sağlık çeklist"
language="tr"

<style>
/* Some custom styling, makes this page more legible. */
body {
  max-width: 80ch !important;
}

ol > li {
  margin-top: 1em;
}
</style>

_İkinci el laptop (bilhassa, ThinkPad) alırken kontrol edilmesinde
fayda olan şeyler cheklisti._

1.  Kozmetik kontroller:
    1.  alt, üst, portlar, ekran, klavye, touchpad, webcam
        -   port ve webcam kapakları, varsa
    2.  takıp çıkıyorsa bataryaya bir bak

2.  Cihazın geçmişi
    1.  windows orijinal mi?
        -   ürün anahtarı?
            -   (bu sonradan yazılımla da bulunabiliyor tabi)
    2.  garanti durumu

3.  BIOS/UEFI
    1.  BIOS şifresi var mı? varsa _problem_!
    2.  anti-theft açık mı? açıksa _problem_!
    3.  [thinkpad] computrace açık mı? açıksa _problem_!
        -   bunların hepsinin kapatılması lazım

4.  Donanım soruları:
    1.  eklenen çıkan değişen ne var?
        -   storage (HDD, SSD, m.2, NVMe, &c)
        -   RAM
        -   wifi vs. kartlar
        -   batarya orijinal mi?
    2.  Klavye sağlam mı?
        -   tüm tuşlara basacak şekilde bir yaz biraz
    3.  Dokunmatikler
        -   touchpad hissiyatı ve hassasiyeti
        -   başka pointing device (trackpoint vs)
        -   dokunmatik ekran varsa, hissiyatı ve hassasiyeti
    4.  Ekran
        -   dead pixel var mı?
        -   ghosting yapıyor mu?
        -   renkler doğru mu?
        -   farklı açılardan ekran ne kadar iyi/kötü gözüküyor?
        -   `dxutils/screentest`
        -   lid switch çalışıyor mu? (suspend/resume)
    5.  Portlar
        -   portlar çalışıyor mu?
        -   takıp çıkarmada bir sorun var mı? sürtünme takılma vs
    6.  Batarya ve şarj aleti
        -   şarj aleti var mı? ne durumda? USB-C mi?
        -   batarya ne durumda? şarj ne kadar süre tutuyor? ne sürede şarj
            oluyor?
    7.  Webcam
        -   görüntü nasıl?

5.  Windows temelli testler ve bilgi edinme araçları
    1.  Start > System Info
    2.  Benim `dxutils` > GSmartControl
    3.  Benim `dxutils` > `HWiNFO`
        -   «hwinfo **should** tell you the total terrabytes written
            as well as estimated remaining life span (as a level of
            wear %) of an ssd storage device if it provides that
            info»<sup>thx klingon friend!</sup>
    4.  Start > Windows Memory Diagnostics (_requires reboot_!)
        -   alternatif: Win+R > `mdsched.exe`
    5.  Start > CMD > Run as administator
        -   `powercfg /batteryreport`
            -   number of cycles & remaining usable capacity
        -   `powercfg /energy`
        -   `chkdisk`
            -   alternatif: `chkdisk C: /x /r`
                -   _fixes errors!_, meaning, **modifies stuff!**
        -   [Opsiyonel] `sfc /scannow`
            -   checks windows system files, can fix if broken

6.  Bootable diagnostic ve test araçları (_Ventoy USB’si içerisinde_)
    1.  [Opsiyonel] **memtest** (memtest86 ya da memtest86+)
        -   soldered memory varsa kesin yap
        -   excecises CPU and cooling system, listen/feel if they’re ok
    2.  [Opsiyonel] bir iki live linux distro açmayı dene

7.  Benchmark temelli testler ve bilgi edinme araçları (_dxutils
    içerisinde_...<sup>thx klingon friend!</sup>)
    1.  run `HWiNFO` along with _Multicore Rendering Bechmark_ of
        CineBench
        -   «make sure the system doesn’t crash and cooling is working as
            it should»
    2.  run `HWiNFO` along with _Unigine Superposition Benchmark_
        -   «to make sure the graphics chip is working and being cooled
            properly»
