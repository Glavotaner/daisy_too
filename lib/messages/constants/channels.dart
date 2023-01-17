class Channel {
  final String id;
  final String name;
  const Channel(this.id, this.name);
  const Channel.pairing()
      : id = 'pairing',
        name = 'Pairing';
  const Channel.kisses()
      : id = 'kisses',
        name = 'Kisses';
}
