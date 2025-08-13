class HymnModel {
  final int number;
  final String title;
  final String header;
  final List<String> verses;
  final List<String> tags;
  final String category;
  final String type;
  final String tune;
  bool isFavorite;
  bool isRecentlyViewed;

  HymnModel({
    required this.number,
    required this.title,
    required this.header,
    required this.verses,
    required this.tags,
    required this.category,
    required this.type,
    required this.tune,
    this.isFavorite = false,
    this.isRecentlyViewed = false,
  });
}

class DemoData {
  static List<HymnModel> hymns = [
    HymnModel(
      number: 1,
      title: "Amazing Grace",
      header: "A timeless hymn of redemption and God's unmerited favor, reminding us that through His grace, we who were once lost are now found.",
      verses: [
        "Amazing grace! how sweet the sound,\nThat saved a wretch like me!\nI once was lost, but now am found,\nWas blind, but now I see.",
        "'Twas grace that taught my heart to fear,\nAnd grace my fears relieved;\nHow precious did that grace appear\nThe hour I first believed!",
        "Through many dangers, toils and snares\nI have already come;\n'Tis grace hath brought me safe thus far,\nAnd grace will lead me home.",
        "When we've been there ten thousand years,\nBright shining as the sun,\nWe've no less days to sing God's praise\nThan when we first begun.",
      ],
      tags: ["Grace", "Redemption", "Salvation"],
      category: "Worship",
      type: "Grace",
      tune: "C.M.S",
    ),
    HymnModel(
      number: 8,
      title: "How Firm A Foundation",
      header: "Built upon the solid rock of God's promises, this hymn assures believers of the unshakeable foundation found in Christ and His unchanging word.",
      verses: [
        "How firm a foundation, ye saints of the Lord,\nIs laid for your faith in his excellent word!\nWhat more can he say than to you he hath said,\nTo you who for refuge to Jesus have fled?",
        "Fear not, I am with thee; O be not dismayed,\nFor I am thy God, and will still give thee aid;\nI'll strengthen thee, help thee, and cause thee to stand,\nUpheld by my righteous, omnipotent hand.",
        "When through the deep waters I call thee to go,\nThe rivers of woe shall not thee overflow;\nFor I will be with thee thy troubles to bless,\nAnd sanctify to thee thy deepest distress.",
        "The soul that on Jesus hath leaned for repose,\nI will not, I will not desert to his foes;\nThat soul, though all hell should endeavor to shake,\nI'll never, no, never, no, never forsake!",
      ],
      tags: ["Faith", "Comfort"],
      category: "Faithfulness",
      type: "Faith",
      tune: "G.H.C",
      isRecentlyViewed: true,
    ),
    // Add more hymns as needed...
  ];

  static List<HymnModel> get favorites => hymns.where((hymn) => hymn.isFavorite).toList();
  static List<HymnModel> get recentlyViewed => hymns.where((hymn) => hymn.isRecentlyViewed).toList();

  static void toggleFavorite(int hymnNumber) {
    final hymn = hymns.firstWhere((h) => h.number == hymnNumber);
    hymn.isFavorite = !hymn.isFavorite;
  }

  static void markAsRecentlyViewed(int hymnNumber) {
    // Clear all recently viewed first
    for (var hymn in hymns) {
      hymn.isRecentlyViewed = false;
    }
    // Mark this one as recently viewed
    final hymn = hymns.firstWhere((h) => h.number == hymnNumber);
    hymn.isRecentlyViewed = true;
  }
}