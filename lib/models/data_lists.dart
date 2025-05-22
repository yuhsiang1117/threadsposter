
class ToneOption {
  final String name;
  final String description;

  const ToneOption(this.name, this.description);
}

const List<ToneOption> toneOptions = [
  ToneOption('None', '無特定角色'),
  ToneOption('Boss', '老闆風格，權威且直接'),
  ToneOption('Simp', '討好型，溫柔且諂媚'),
];

const List<String> styleOptions = [
  'Emotion',
  'Practicle',
  'Identity',
  'Trend',
];

const List<String> size = [
  'Short',
  'Medium',
  'Long',
];

const List<String> tagOptions = [
  "#地震",
  "#颱風",
  "#大雨",
  "#大雪",
  "#大霧",
  "#大風",
  "#大火",
];