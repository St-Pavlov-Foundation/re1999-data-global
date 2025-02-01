module("modules.logic.rouge.view.RougeTalentTreeBranchItem", package.seeall)

slot0 = class("RougeTalentTreeBranchItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.viewGO = slot1
end

function slot0.initcomp(slot0, slot1, slot2)
	slot0._config = slot1
	slot0._id = slot1.id
	slot0.isOrigin = slot0._config.isOrigin == 1
	slot0._parentIndex = slot2
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._goselectframe = gohelper.findChild(slot0.viewGO, "#go_selectframe")
	slot0._imagetalenicon = gohelper.findChildImage(slot0.viewGO, "#image_talenicon")
	slot0._gotalentname = gohelper.findChild(slot0.viewGO, "talenname")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "#txt_progress")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "#go_locked")
	slot0._goprogressunfull = gohelper.findChild(slot0.viewGO, "#go_progress_unfull")
	slot0._goprogressunfullLight = gohelper.findChild(slot0.viewGO, "#go_progress_unfull/small_light")
	slot0._imgprogress = gohelper.findChildImage(slot0.viewGO, "#go_progress_unfull/circle")
	slot0._goprogressfull = gohelper.findChild(slot0.viewGO, "#go_progress_full")
	slot0._goup = gohelper.findChild(slot0.viewGO, "#go_up")
	slot0._golight = gohelper.findChild(slot0.viewGO, "#go_light")

	gohelper.setActive(slot0._golight, false)

	slot0._gocanselect = gohelper.findChild(slot0.viewGO, "#go_canselect")
	slot0._selectGO = gohelper.findChild(slot0.viewGO, "#go_select")

	gohelper.setActive(slot0._selectGO, true)

	slot0._selectGOs = {}

	for slot6 = 1, 3 do
		slot0._selectGOs[slot6] = gohelper.findChild(slot0.viewGO, "#go_select/" .. slot6)
	end

	slot0._showAnim = false

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	RougeController.instance:dispatchEvent(RougeEvent.OnClickTreeNode, slot0._config)
	AudioMgr.instance:trigger(AudioEnum.UI.SelcetTalentItem)
end

function slot0._editableInitView(slot0)
	slot0:addEvents()
end

function slot0.refreshItem(slot0, slot1, slot2)
	slot8 = RougeTalentModel.instance:getUnlockNumByTalent(slot0._parentIndex) / RougeTalentConfig.instance:getBranchNumByTalent(slot0._parentIndex) >= 1
	slot0._imgprogress.fillAmount = slot7

	gohelper.setActive(slot0._goprogressunfull, not slot8 and slot0.isOrigin)
	gohelper.setActive(slot0._goprogressfull, slot8 and slot0.isOrigin)
	gohelper.setActive(slot0._gocanselect, RougeTalentModel.instance:checkNodeCanLevelUp(slot0._config))

	if slot0._config.cost == 1 then
		transformhelper.setLocalScale(slot0._golight.transform, 0.5, 0.5, 1)
	else
		transformhelper.setLocalScale(slot0._golight.transform, 0.8, 0.8, 1)
	end

	if slot2 and slot2 == slot0._config.id then
		gohelper.setActive(slot0._golight, true)
		AudioMgr.instance:trigger(AudioEnum.UI.LightTalentItem)
	else
		gohelper.setActive(slot0._golight, false)
	end

	slot10 = RougeTalentModel.instance:checkNodeLock(slot0._config)

	if slot9 and not slot0.isOrigin then
		if slot4 then
			transformhelper.setLocalScale(slot0._gocanselect.transform, 0.5, 0.5, 1)
		else
			transformhelper.setLocalScale(slot0._gocanselect.transform, 0.8, 0.8, 1)
		end
	end

	gohelper.setActive(slot0._gotalentname, false)
	gohelper.setActive(slot0._txtprogress.gameObject, false)
	gohelper.setActive(slot0._golocked, false)

	if not string.nilorempty(slot0._config.icon) then
		if RougeTalentModel.instance:checkNodeLight(slot0._config.id) then
			UISpriteSetMgr.instance:setRougeSprite(slot0._imagetalenicon, slot0._config.icon)
		else
			UISpriteSetMgr.instance:setRougeSprite(slot0._imagetalenicon, slot0._config.icon .. "_locked")
		end
	end

	gohelper.setActive(slot0._goprogress, slot0.isOrigin)
	gohelper.setActive(slot0._goprogressunfullLight, not slot10 and not slot8 and RougeTalentModel.instance:getUnlockNumByTalent(slot0._parentIndex) > 0 and slot0.isOrigin)

	if slot1 then
		slot13 = 0

		gohelper.setActive(slot0._selectGOs[slot0.isOrigin and 3 or slot4 and 1 or 2], true)
	else
		for slot16, slot17 in ipairs(slot0._selectGOs) do
			gohelper.setActive(slot17, false)
		end
	end
end

function slot0.getID(slot0)
	return slot0._id
end

function slot0.onDestroy(slot0)
end

function slot0.dispose(slot0)
	slot0:removeEvents()
	slot0:__onDispose()
end

return slot0
