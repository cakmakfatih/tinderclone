final List<Profile> demoProfiles = [
  Profile (
    photos: [
      "https://scontent-frt3-1.xx.fbcdn.net/v/t1.0-9/21034153_10209767523040078_2266299136074458286_n.jpg?_nc_cat=101&_nc_ht=scontent-frt3-1.xx&oh=e0eec3ce25219f6127321c8d6bcf1577&oe=5CFF5452",
      "https://scontent-frt3-1.xx.fbcdn.net/v/t1.0-9/27332554_10210827091208620_5723348064568921443_n.jpg?_nc_cat=106&_nc_ht=scontent-frt3-1.xx&oh=ee68ac8de8c62d692a0b6df1eb2f0730&oe=5CD1AC9A",
      "https://i.hizliresim.com/Ov0L7A.jpg",
      "https://i.hizliresim.com/nQRWLB.jpg",
    ],
    name: "Fatih",
    age: 22,
    distance: 4,
    education: "Hacettepe University"
  ),
  Profile (
    photos: [
      "https://scontent-frt3-1.xx.fbcdn.net/v/t1.0-9/27332554_10210827091208620_5723348064568921443_n.jpg?_nc_cat=106&_nc_ht=scontent-frt3-1.xx&oh=ee68ac8de8c62d692a0b6df1eb2f0730&oe=5CD1AC9A",
      "https://i.hizliresim.com/nQRWLB.jpg",
      "https://scontent-frt3-1.xx.fbcdn.net/v/t1.0-9/21034153_10209767523040078_2266299136074458286_n.jpg?_nc_cat=101&_nc_ht=scontent-frt3-1.xx&oh=e0eec3ce25219f6127321c8d6bcf1577&oe=5CFF5452",
    ],
    name: "Elysium",
    age: 23,
    distance: 2,
    bio: "Test bio"
  )
];

class Profile {

  final List<String> photos;
  final String name;
  final int age;
  final String education;
  final String bio;
  final int distance;

  Profile({
    this.photos,
    this.name,
    this.age,
    this.education,
    this.bio,
    this.distance
  });

}