module("modules.logic.character.controller.CharacterRecommedEvent", package.seeall)

return {
	OnChangeHero = GameUtil.getEventId(),
	OnCutHeroAnimCB = GameUtil.getEventId(),
	OnLoadFinishTracedIcon = GameUtil.getEventId(),
	OnRefreshTraced = GameUtil.getEventId(),
	OnJumpView = GameUtil.getEventId()
}
