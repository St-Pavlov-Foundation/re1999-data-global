module("modules.logic.weekwalk.view.WeekWalkBuffBindingHeroItem", package.seeall)

slot0 = class("WeekWalkBuffBindingHeroItem", HeroGroupEditItem)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)
	slot0:enableDeselect(false)
end

function slot0._onItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, slot0._mo)
end

function slot0.onDestroy(slot0)
end

return slot0
