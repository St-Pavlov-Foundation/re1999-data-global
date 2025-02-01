module("modules.logic.seasonver.act166.view.information.Season166InformationAnalyDetailItemBase", package.seeall)

slot0 = class("Season166InformationAnalyDetailItemBase", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.itemType = slot1
end

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1

	slot0:onInit()
end

function slot0.onInit(slot0)
end

function slot0.setData(slot0, slot1)
	slot0.data = slot1

	if not slot1 then
		gohelper.setActive(slot0.go, false)

		return
	end

	gohelper.setActive(slot0.go, true)
	gohelper.setAsLastSibling(slot0.go)
	gohelper.setActive(slot0.goLine, not slot1.isEnd)
	slot0:onUpdate()
end

function slot0.onUpdate(slot0)
end

function slot0.playTxtFadeInByStage(slot0, slot1)
	if not slot0.data then
		return
	end

	if slot0.data.config and slot2.stage == slot1 then
		slot0:playFadeIn()
	end
end

function slot0.playFadeIn(slot0)
end

function slot0.getPosY(slot0)
	return recthelper.getAnchorY(slot0.go.transform)
end

function slot0.onRecycle(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.onDestroy(slot0)
	slot0:__onDispose()
end

return slot0
