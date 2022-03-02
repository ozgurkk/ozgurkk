####  Sayı Tahmin Oyunu v.0.0.0.0.1
print("0 ile yuz arasi bir sayi giriniz. Gireceginiz sayi orijinal sayinin 10 sayı eksik yada fazlası olabilir")
Sayi1 = int(input("Bir sayi giriniz"))
Sayi2 = int(input("Bir sayi daha giriniz"))

sonuc = int(Sayi1 + Sayi2)

if (sonuc) <= int("10"):
    print ("Sonucunuz dogru")

else:
    print("sonucunuz yanlis")
# print("Sayilariniz sonucu",sonuc) ## alternate usage