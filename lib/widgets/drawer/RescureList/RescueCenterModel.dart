class RescueCenterModel {
  String name;
  String img_url;
  String location;
  String description;
  String contact;

  RescueCenterModel(
      this.name, this.img_url, this.location, this.description, this.contact);
}

final List<RescueCenterModel> rescueCenters = [
  RescueCenterModel(
      "Sneha's care",
      "https://www.snehacare.org/wp-content/uploads/2022/03/Snehas-Care-Logo-Master-e1647252640733.png",
      "Karyabinayak",
      "Sneha’s Care is a non-profit organization established in 2015 in the Lalitpur district of Nepal. Sneha’s care is committed to creating a society where all animals are treated humanely. Protecting community dogs and animals from all forms of abuse, cruelty, and torture is the main focus of the work. In order for this to happen, Sneha’s care could not limit its program to saving animals and providing for their medical requirements. Sneha’s Care started various projects for the welfare of animals and community dogs to stop animal cruelty. In order to create rigorous animal welfare policies, we promote animal welfare and work with government agencies and other organizations with similar visions. We believe that ending factory farming and other forms of animal exploitation should be a goal for every individual, organization, and government.",
      "980-8645023"),
  RescueCenterModel(
      "Kathmandu Animal Treatment Centre",
      "https://yt3.ggpht.com/ytc/AMLnZu8FuSR0wdusE5EGv7qSZPDxIcAb0ARwGZ6ziYiw=s900-c-k-c0x00ffffff-no-rj",
      "Budhanilkantha",
      "The Kathmandu Animal Treatment Centre (KAT Centre) was first envisioned after Jan Salter, the founder of KAT, visited the organization Help in Suffering in Jaipur, India.Impressed with the way this and other animal welfare organizations have managed difficult street dog problems and eliminated rabies through Animal Birth Control (ABC) and widespread rabies vaccinations, Jan came back to Nepal convinced that Kathmandu, Nepal could also become a rabies-free, dog-friendly city.",
      "984-3810363"),
  RescueCenterModel(
      "Shree's Animal Rescue",
      "https://english.onlinekhabar.com/wp-content/uploads/2018/11/Shrees-animal-resue-1.jpg",
      "Gokarneshwar",
      "Dedicated to save lives of street dogs in Nepal and lending a paw to animals in need!"
          "Please donate"
          "eSewa 9841344997"
          "Esewa (9841344997)"
          "https://www.paypal.me/bhanuthakuri",
      "N/A"),
  RescueCenterModel(
      "Kopan Community Dog Welfare Center",
      "https://yellow.place/file/image/thumb/0/0/560/ilodnzoeldiznigq.jpg",
      "Budhanilkantha",
      "Welcome to Community Dog Welfare Kopan, a non-profit organization dedicated to developing community awareness and responsibility for dog welfare near Kopan Monastery on the outskirts of Kathmandu, Nepal."
          "Community Dog Welfare evolved from caring for dogs picked up on the street and brought home for veterinary treatment and recovery.  With local and international support we have created an expanding network for dog welfare through practical assistance, low cost treatment, dog health programmes and creating awareness, all of which have received a positive response in the local community.  Care is provided for sick, injured, aged and abandoned dogs in our rescue centre.",
      "980-3976378")
];
