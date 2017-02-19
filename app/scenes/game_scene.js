import Scene from "../scene"
import Camera from "../camera"
import Ship from "../entities/ship"

import "keymaster"

class GameScene extends Scene {
  constructor(game) {
    super(game)

    this.camera = new Camera(this.stage, this.game.app.renderer.width, this.game.app.renderer.height)

    this.ship = new Ship()
    this.stage.addChild(this.ship)
  }

  update(delta) {
    this.handleInput()
    this.camera.lookAt(this.ship.position)
  }

  handleInput() {
    if (key.isPressed("A") || key.isPressed("left"))
      this.ship.rotation -= 0.01
  }
}

export default GameScene
