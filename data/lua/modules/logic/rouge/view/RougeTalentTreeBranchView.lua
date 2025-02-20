module("modules.logic.rouge.view.RougeTalentTreeBranchView", package.seeall)

slot0 = class("RougeTalentTreeBranchView", BaseView)

function slot0.onInitView(slot0)
	slot0._tabIndex = slot0.viewContainer:getTabView()._curTabId
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btnempty = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_empty")
	slot0._treenodeList = {}
	slot0._treeLightList = {}
	slot0._curSelectId = nil
	slot0._orderToDelayTime = {}
	slot0._flexibleTime = 0.3

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, slot0._refreshUI, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnClickTreeNode, slot0._SelectItem, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnCancelTreeNode, slot0.cancelSelectNode, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.onSwitchTab, slot0._onSwitchTab, slot0)
	slot0._btnempty:AddClickListener(slot0._btnemptyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, slot0._refreshUI, slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnClickTreeNode, slot0._SelectItem, slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnCancelTreeNode, slot0.cancelSelectNode, slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.onSwitchTab, slot0._onSwitchTab, slot0)
	slot0._btnempty:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0._btnemptyOnClick(slot0)
	RougeController.instance:dispatchEvent(RougeEvent.OnClickEmpty, slot0._tabIndex)
end

function slot0._refreshUI(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._treenodeList) do
		if slot0._curSelectId == slot6:getID() then
			if slot1 and slot1 == slot6:getID() then
				slot6:refreshItem(false, slot1)
			else
				slot6:refreshItem(true)
			end
		else
			slot6:refreshItem(false)
		end
	end

	for slot5, slot6 in ipairs(slot0._treeLightList) do
		slot0:_refreshLight(slot6)
	end

	if slot0._canplayAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.LightTalentBranch)

		slot0._canplayAudio = false
	end
end

function slot0._onSwitchTab(slot0, slot1)
	if not (slot0._tabIndex == slot1) then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	slot6 = true

	gohelper.setActive(slot0.viewGO, slot6)

	for slot6, slot7 in ipairs(slot0._treeLightList) do
		if slot7.isPlayAnim then
			slot7.isPlayAnim = false

			gohelper.setActive(slot7.go, false)
		end

		slot0:_refreshLight(slot7)
	end

	if slot0._canplayAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.LightTalentBranch)

		slot0._canplayAudio = false
	end
end

function slot0._SelectItem(slot0, slot1)
	if not slot1 then
		return
	end

	slot3 = slot1.id

	for slot7, slot8 in ipairs(slot0._treenodeList) do
		if slot0._tabIndex == slot1.talent and slot8:getID() == slot3 then
			if not slot0._curSelectId then
				slot8:refreshItem(true)

				slot0._curSelectId = slot3
			elseif slot0._currentSelectId ~= slot3 then
				slot8:refreshItem(true)

				slot0._curSelectId = slot3
			end
		else
			slot8:refreshItem(false)
		end
	end
end

function slot0.cancelSelectNode(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._treenodeList) do
		if slot1 == slot6:getID() then
			slot6:refreshItem(false)

			slot0._curSelectId = nil

			break
		end
	end
end

function slot0.onOpen(slot0)
	if not RougeTalentModel.instance:checkIsCurrentSelectView(slot0._tabIndex) then
		return
	end

	slot0._config = RougeTalentConfig.instance:getBranchConfigListByTalent(slot0._tabIndex)
	slot0._branchconfig = RougeTalentConfig.instance:getBranchLightConfigByTalent(slot0._tabIndex)

	if not slot0._branchconfig then
		logError("genuis_branch_light " .. slot0._tabIndex .. " not config!!!!")
	end

	slot0:_inititem()
	slot0:_initLight()
end

function slot0._inititem(slot0)
	for slot4, slot5 in ipairs(slot0._config) do
		if not slot0._treenodeList[slot4] then
			slot6 = slot0:getUserDataTb_()

			if slot0.viewContainer:getPoolView() then
				slot6 = slot9:getIcon(gohelper.findChild(slot0.viewGO, "item/#go_item" .. string.gsub(slot5.pos, "#", "_")))
			end

			slot0._treenodeList[slot4] = slot6
		end

		slot6:initcomp(slot5, slot0._tabIndex)
		slot6:refreshItem()
	end
end

function slot0._initLight(slot0)
	slot0._canplayAudio = false

	for slot4, slot5 in ipairs(slot0._branchconfig) do
		if not slot0._treeLightList[slot4] then
			slot6 = slot0:getUserDataTb_()
			slot8 = gohelper.findChild(slot0.viewGO, "light/" .. slot5.lightname):GetComponent(typeof(UnityEngine.Animator))

			if slot5.pos then
				slot9 = {}

				if string.find(slot5.pos, "|") then
					for slot14, slot15 in ipairs(string.split(slot5.pos, "|")) do
						table.insert(slot9, string.splitToNumber(slot15, "#"))
					end
				else
					table.insert(slot9, string.splitToNumber(slot5.pos, "#"))
				end

				if slot9 then
					slot6.posList = slot9
				end
			end

			slot6.index = slot4
			slot6.name = slot5.lightname
			slot6.go = slot7

			gohelper.setActive(slot6.go, false)

			slot6.animator = slot8
			slot6.talent = slot5.talent
			slot6.order = slot5.order
			slot6.allLight = slot0:_checkCanLight(slot6)
			slot6.isPlayAnim = false

			for slot13 = 0, slot6.animator.runtimeAnimatorController.animationClips.Length - 1 do
				if slot9[slot13].name:find("_light$") then
					slot6.animtime = slot9[slot13].length
				end
			end
		end

		table.insert(slot0._treeLightList, slot6)
		slot0:_refreshLight(slot6)
	end

	if slot0._canplayAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.LightTalentBranch)

		slot0._canplayAudio = false
	end
end

function slot0._getDelayTime(slot0, slot1)
	slot2 = 0

	if slot0._orderToDelayTime[slot1.order] then
		return slot0._orderToDelayTime[slot3]
	end

	slot4 = nil

	for slot8 = 1, #slot0._treeLightList do
		if slot8 > 1 and slot3 > 1 then
			slot4 = slot0._treeLightList[slot8 - 1]

			if slot0._orderToDelayTime[slot3 - 1] then
				slot2 = slot0._orderToDelayTime[slot3 - 1] + slot1.animtime - slot0._flexibleTime

				break
			else
				slot2 = slot1.animtime - slot0._flexibleTime

				break
			end
		end
	end

	if slot2 > 0 then
		slot0._orderToDelayTime[slot3] = slot2
	end

	return slot2
end

function slot0._checkCanLight(slot0, slot1)
	for slot6, slot7 in ipairs(slot1.posList) do
		for slot12, slot13 in ipairs(slot7) do
			if RougeTalentModel.instance:checkNodeLight(slot13) then
				slot8 = 0 + 1
			end
		end

		if slot8 == #slot7 then
			return true
		end
	end

	return false
end

function slot0.onClose(slot0)
	slot0:recycleTreeNode()
end

function slot0.recycleTreeNode(slot0)
	if slot0._treenodeList then
		for slot5, slot6 in ipairs(slot0._treenodeList) do
			slot0.viewContainer:getPoolView():recycleIcon(slot0._treenodeList[slot5])

			slot0._treenodeList[slot5] = nil
		end
	end
end

function slot0._refreshLight(slot0, slot1)
	slot2 = slot0:_getDelayTime(slot1)

	function slot0.playfunc(slot0)
		if not uv0.viewContainer or not uv0.viewContainer._isVisible then
			return
		end

		TaskDispatcher.cancelTask(uv0.playfunc, slot0)
		gohelper.setActive(slot0.go, true)
		slot0.animator:Update(0)
		slot0.animator:Play("light", 0, 0)

		slot0.isPlayAnim = true
	end

	if not slot0:_checkCanLight(slot1) then
		gohelper.setActive(slot1.go, false)
	elseif not slot1.isPlayAnim then
		if slot1.allLight then
			TaskDispatcher.runDelay(slot0.playfunc, slot1, slot2)

			slot0._canplayAudio = true
		else
			TaskDispatcher.runDelay(slot0.playfunc, slot1, slot0:_checkBeforeBranchAllLightReturnDelayTime(slot1))

			slot1.allLight = true
			slot0._canplayAudio = true
		end
	end
end

function slot0._checkBeforeBranchAllLightReturnDelayTime(slot0, slot1)
	slot2 = 0
	slot3 = slot1

	while slot3.index > 1 and slot3.order > 1 do
		slot2 = slot2 + slot0:getBeforeLightAniTime(slot3)
		slot3 = slot0._treeLightList[slot3.index - 1]
	end

	return slot2
end

function slot0.getBeforeLightAniTime(slot0, slot1)
	slot2 = 0

	if slot0._treeLightList[slot1.index - 1].allLight and not slot3.isPlayAnim then
		slot2 = slot1.animtime - slot0._flexibleTime
	end

	return slot2
end

function slot0.onDestroyView(slot0)
end

return slot0
