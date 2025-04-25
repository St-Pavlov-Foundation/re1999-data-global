module("modules.logic.versionactivity2_5.act186.view.Activity186GameHeroView", package.seeall)

slot0 = class("Activity186GameHeroView", Activity186HeroView)

function slot0._onClick(slot0)
end

function slot0._onLightSpineLoaded(slot0)
	slot0._uiSpine:showModel()
	slot0._uiSpine:setActionEventCb(slot0._onAnimEnd, slot0)
	slot0._uiSpine:play("b_daoju", true)
	gohelper.setActive(slot0._gocontentbg, true)
end

function slot0.showText(slot0, slot1)
	if string.nilorempty(slot1) then
		gohelper.setActive(slot0._gocontentbg, false)
	else
		gohelper.setActive(slot0._gocontentbg, true)

		slot0._txtanacn.text = slot1
	end
end

return slot0
