export default class HealthModel {
  health: string = '';
  color: Color = Color.Red;

  constructor(
    health: string,
    color: Color
  ) {
    this.health = health;
    this.color = color;
  }
}