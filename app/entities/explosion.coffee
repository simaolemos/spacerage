Vec2 = require "../vec2"

class Explosion extends PIXI.Container
  constructor: ->
    super()
    @scale.set(0.5)

    @finished = false

    @addChild @makeSplosion(Vec2.origin, 70, 1, 0xFFFF00)

    for i in [1..10]
      pos = Vec2.up.rotate(Math.random() * Math.PI * 2).scale(20 + Math.random() * 30)
      @addChild @makeSplosion(pos, 5 + Math.random() * 40, 0.5 + Math.random() * 0.5)

    new TWEEN.Tween(@)
      .delay(500)
      .to({alpha: 0.0}, 1000)
      .easing(TWEEN.Easing.Quadratic.Out)
      .onComplete =>
        @finished = true
      .start()

  makeSplosion: (pos, radius = 50, alpha = 1, color = 0xFFFFFF) ->
    s = new PIXI.Graphics
    s.beginFill(color, alpha - 0.2)
    s.drawCircle(pos.x, pos.y, radius)
    s.beginFill(color, alpha)
    s.drawCircle(pos.x * (0.8 + Math.random() * 0.4), pos.y * (0.8 + Math.random() * 0.4), radius * 0.8)
    s._scale = 1

    targetPos = pos.scale(1.6)

    new TWEEN.Tween(s)
      .to({_scale: 2, x: targetPos.x, y: targetPos.y}, 1000)
      .easing(TWEEN.Easing.Quadratic.Out)
      .start()

    s.update = ->
      s.scale.set(s._scale)

    s

  update: ->
    for splosion in @children
      splosion.update()

module.exports = Explosion
