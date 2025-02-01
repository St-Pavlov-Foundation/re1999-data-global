module("modules.logic.rouge.view.RougeTalentTreeItem", package.seeall)

slot0 = class("RougeTalentTreeItem", LuaCompBase)

function slot0.initcomp(slot0, slot1, slot2, slot3)
	slot0._go = slot1
	slot0._config = slot2
	slot0._index = slot3
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0._go, "#btn_click")
	slot0._goselectframe = gohelper.findChild(slot0._go, "#go_selectframe")
	slot0._imagetalenicon = gohelper.findChildImage(slot0._go, "#image_talenicon")
	slot0._gotalenname = gohelper.findChild(slot0._go, "talenname")
	slot0._txttalenname = gohelper.findChildText(slot0._go, "talenname/#txt_talenname")
	slot0._txtprogress = gohelper.findChildText(slot0._go, "#txt_progress")
	slot0._golocked = gohelper.findChild(slot0._go, "#go_locked")
	slot0._goprogressunfull = gohelper.findChild(slot0._go, "#go_progress_unfull")
	slot0._goprogressunfullLight = gohelper.findChild(slot0._go, "#go_progress_unfull/small_light")
	slot0._imgprogress = gohelper.findChildImage(slot0._go, "#go_progress_unfull/circle")
	slot0._goprogressfull = gohelper.findChild(slot0._go, "#go_progress_full")
	slot0._golocked = gohelper.findChild(slot0._go, "#go_locked")
	slot0._animlock = slot0._golocked:GetComponent(typeof(UnityEngine.Animator))
	slot0._goup = gohelper.findChild(slot0._go, "#go_up")
	slot0._selectGO = gohelper.findChild(slot0._go, "#go_select")

	gohelper.setActive(slot0._selectGO, false)

	slot0._beforestatus = nil
	slot0._backViewOpenTime = 0.2

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.reallyExitTalentView, slot0._onBackView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0:addEventCb(RougeController.instance, RougeEvent.reallyExitTalentView, slot0._onBackView, slot0)
end

function slot0._btnclickOnClick(slot0)
	RougeController.instance:dispatchEvent(RougeEvent.enterTalentView, slot0._index)
end

function slot0._editableInitView(slot0)
	slot0:addEvents()
end

function slot0.refreshItem(slot0)
	if not RougeTalentModel.instance:checkBigNodeLock(slot0._index) then
		slot0._animlock:Update(0)
		slot0._animlock:Play("idle", 0, 0)
		gohelper.setActive(slot0._golocked, slot1)
	end

	if not slot0._beforestatus then
		slot0._beforestatus = slot1
	end

	slot3 = false
	slot4 = false

	if RougeTalentModel.instance:getNextNeedUnlockTalent() then
		for slot8, slot9 in pairs(slot2) do
			if slot9 == slot0._index then
				slot4 = true

				break
			end
		end
	end

	slot3 = slot1 and slot4

	gohelper.setActive(slot0._gotalenname, not slot1 or slot3)
	gohelper.setActive(slot0._txtprogress.gameObject, slot3)
	gohelper.setActive(slot0._goup, RougeTalentModel.instance:checkBigNodeShowUp(slot0._index))

	slot9 = RougeTalentModel.instance:getUnlockNumByTalent(slot0._index) / RougeTalentConfig.instance:getBranchNumByTalent(slot0._index) >= 1
	slot0._imgprogress.fillAmount = slot8

	if not string.nilorempty(slot0._config.icon) then
		if slot1 then
			UISpriteSetMgr.instance:setRougeSprite(slot0._imagetalenicon, slot0._config.icon .. "_locked")
		elseif slot6 > 0 then
			UISpriteSetMgr.instance:setRougeSprite(slot0._imagetalenicon, slot0._config.icon)
		else
			UISpriteSetMgr.instance:setRougeSprite(slot0._imagetalenicon, slot0._config.icon .. "_locked")
		end
	end

	slot0._txtprogress.text = string.format("<color=%s>%s</color>", "#E99B56", RougeTalentModel.instance:getHadConsumeTalentPoint()) .. "/" .. RougeTalentConfig.instance:getConfigByTalent(RougeOutsideModel.instance:season(), slot0._index).cost
	slot0._txttalenname.text = slot0._config.name

	gohelper.setActive(slot0._goprogressunfullLight, not slot1 and not slot9 and RougeTalentModel.instance:getUnlockNumByTalent(slot0._index) > 0)
	gohelper.setActive(slot0._goprogressunfull, not slot9)
	gohelper.setActive(slot0._goprogressfull, slot9)
end

function slot0._onBackView(slot0)
	function slot0.backopenfunc()
		TaskDispatcher.cancelTask(uv0.backopenfunc, uv0)

		if uv0._beforestatus ~= RougeTalentModel.instance:checkBigNodeLock(uv0._index) then
			gohelper.setActive(uv0._golocked, true)
			uv0._animlock:Update(0)
			uv0._animlock:Play("unlock", 0, 0)

			uv0._beforestatus = slot0
		end
	end

	TaskDispatcher.runDelay(slot0.backopenfunc, slot0, slot0._backViewOpenTime)
end

function slot0.dispose(slot0)
	slot0:removeEvents()
	slot0:__onDispose()
end

return slot0
