module("modules.logic.rouge.view.RougeTalentTreeTrunkView", package.seeall)

slot0 = class("RougeTalentTreeTrunkView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simageallfininshedlight = gohelper.findChildSingleImage(slot0.viewGO, "#simage_allfininshed_light")
	slot0._btnoverview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_overview")
	slot0._gotoprighttips = gohelper.findChild(slot0.viewGO, "#go_topright/tips")
	slot0._txttoprighttips = gohelper.findChildText(slot0.viewGO, "#go_topright/tips/#txt_tips")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_topright/#txt_num")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_click")
	slot0._btnempty = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_empty")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._treenodeList = {}
	slot0._treeLightList = {}
	slot0._orderToDelayTime = {}
	slot0._orderToLightList = {}
	slot0._flexibleTime = 0.2

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnoverview:AddClickListener(slot0._btnoverviewOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnempty:AddClickListener(slot0._btnclickEmpty, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, slot0._refreshUI, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.enterTalentView, slot0._onClickTalentTreeItem, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.reallyExitTalentView, slot0._onBackView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnoverview:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
	slot0._btnempty:RemoveClickListener()
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, slot0._refreshUI, slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.enterTalentView, slot0._onClickTalentTreeItem, slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.reallyExitTalentView, slot0._onBackView, slot0)
end

function slot0._editableInitView(slot0)
	slot0._season = RougeOutsideModel.instance:season()
	slot0._config = RougeTalentConfig.instance:getRougeTalentDict(slot0._season)
	slot0._lightconfig = RougeTalentConfig.instance:getBranchLightConfigByTalent(999)
end

function slot0._refreshUI(slot0)
	for slot4, slot5 in ipairs(slot0._treenodeList) do
		slot5.component:refreshItem()
	end

	for slot4, slot5 in ipairs(slot0._treeLightList) do
		slot0:_refreshLight(slot5)
	end

	slot0._txtnum.text = RougeTalentModel.instance:getTalentPoint()
	slot0._txttoprighttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_talenttree_remaintalent"), {
		RougeTalentModel.instance:getHadAllTalentPoint(),
		RougeConfig.instance:getOutSideConstValueByID(RougeEnum.OutsideConst.SkillPointLimit)
	})
end

function slot0._btnclickOnClick(slot0)
	slot0._isopentips = not slot0._isopentips

	gohelper.setActive(slot0._gotoprighttips, slot0._isopentips)
end

function slot0._btnclickEmpty(slot0)
	if slot0._isopentips then
		slot0._isopentips = false

		gohelper.setActive(slot0._gotoprighttips, slot0._isopentips)
	end
end

function slot0.onOpen(slot0)
	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(slot0._season)
	RougeOutsideRpc.instance:sendRougeMarkGeniusNewStageRequest(slot0._season)
	AudioMgr.instance:trigger(AudioEnum.UI.OpenTalentTrunkTreeView)

	slot0._txtnum.text = RougeTalentModel.instance:getTalentPoint()

	slot0:_initItem()
	slot0:_initLight()
end

function slot0._initItem(slot0)
	for slot4, slot5 in ipairs(slot0._config) do
		if not slot0._treenodeList[slot4] then
			slot6 = slot0:getUserDataTb_()
			slot9 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes.branchitem, gohelper.findChild(slot0.viewGO, "item/#go_item" .. slot4), "treenode" .. tostring(slot4))
			slot10 = MonoHelper.addNoUpdateLuaComOnceToGo(slot9, RougeTalentTreeItem)

			slot10:initcomp(slot9, slot5, slot4)

			slot6.go = slot9
			slot6.component = slot10
			slot0._treenodeList[slot4] = slot6
		end
	end
end

function slot0._initLight(slot0)
	for slot4, slot5 in ipairs(slot0._lightconfig) do
		if not slot0._treeLightList[slot4] then
			slot6 = slot0:getUserDataTb_()

			if not gohelper.findChild(slot0.viewGO, "light/" .. slot5.lightname) then
				logError("genuis_branch_light " .. slot0._tabIndex .. " not config!!!!")
			end

			slot8 = slot7:GetComponent(typeof(UnityEngine.Animator))

			if slot5.pos then
				slot9 = {}

				if string.splitToNumber(slot5.pos, "|") then
					slot6.posList = slot9
				end
			end

			slot6.name = slot5.lightname
			slot6.go = slot7
			slot6.index = slot4

			gohelper.setActive(slot6.go, false)

			slot6.animator = slot8
			slot6.talent = slot5.talent
			slot6.order = slot5.order
			slot6.allLight = slot0:_checkCanLight(slot6)
			slot6.isPlayAnim = false

			if slot8 then
				for slot13 = 0, slot6.animator.runtimeAnimatorController.animationClips.Length - 1 do
					if slot9[slot13].name:find("_light$") then
						slot6.animtime = slot9[slot13].length
						slot6.animCilp = slot9[slot13]
					end
				end
			end
		end

		table.insert(slot0._treeLightList, slot6)

		if not slot0._orderToLightList[slot5.order] then
			slot0._orderToLightList[slot5.order] = {}
		end

		table.insert(slot0._orderToLightList[slot5.order], slot6)
	end

	for slot4, slot5 in ipairs(slot0._treeLightList) do
		slot0:_refreshLight(slot5)
	end
end

function slot0._checkCanLight(slot0, slot1)
	if slot1.order == 1 then
		return true
	end

	for slot6, slot7 in ipairs(slot1.posList) do
		if not RougeTalentModel.instance:checkBigNodeLock(slot7) then
			return true
		end
	end

	return false
end

function slot0._getDelayTime(slot0, slot1)
	if not slot1.animator then
		return 0
	end

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

function slot0._btnoverviewOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RougeTalentTreeOverview)
end

function slot0._onClickTalentTreeItem(slot0, slot1)
	if slot0._inAnim then
		return
	end

	slot0._inAnim = true

	slot0._animator:Update(0)
	slot0._animator:Play("click", 0, 0)

	function slot0._openCallBack()
		TaskDispatcher.cancelTask(uv0._openCallBack, uv0)

		uv0._inAnim = false

		RougeTalentModel.instance:setCurrentSelectIndex(uv1)
		ViewMgr.instance:openView(ViewName.RougeTalentTreeView, uv1)
	end

	TaskDispatcher.runDelay(slot0._openCallBack, slot0, 0.5)
end

function slot0._refreshLight(slot0, slot1)
	slot3 = RougeTalentModel.instance:getNextNeedUnlockTalent()
	slot4 = false

	if not slot0:_checkCanLight(slot1) then
		for slot8, slot9 in ipairs(slot3) do
			for slot13, slot14 in ipairs(slot1.posList) do
				if slot9 == slot14 then
					slot4 = true

					break
				end
			end
		end

		if not slot4 then
			gohelper.setActive(slot1.go, false)
		elseif slot0:_getLightPer(slot1) > 0 then
			gohelper.setActive(slot1.go, true)
			slot1.animator:Update(0)
			slot1.animator:Play("light", 0, slot5 * slot1.animtime)

			slot1.animator.speed = 0
		else
			gohelper.setActive(slot1.go, false)
		end
	else
		gohelper.setActive(slot1.go, true)
		slot1.animator:Update(0)
		slot1.animator:Play("idle", 0, 0)
	end
end

function slot0._getLightPer(slot0, slot1)
	slot3 = nil
	slot4 = 0
	slot5 = 0

	for slot9, slot10 in ipairs(slot0._orderToLightList[slot1.order - 1]) do
		if #slot10.posList == 0 then
			slot3 = slot10

			break
		end

		for slot14, slot15 in ipairs(slot10.posList) do
			if slot4 < slot15 then
				slot4 = slot15
				slot5 = slot14
				slot3 = slot10
			end
		end
	end

	slot6 = RougeOutsideModel.instance:season()
	slot11 = RougeTalentConfig.instance:getConfigByTalent(slot6, slot3.posList[slot5] or 1).cost or 0

	return (RougeTalentModel.instance:getHadAllTalentPoint() - slot11) / (RougeTalentConfig.instance:getConfigByTalent(slot6, slot1.posList[1]).cost - slot11)
end

function slot0._checkBeforeBranchAllLightReturnDelayTime(slot0, slot1)
	slot2 = 0
	slot3 = slot1

	while slot3.index > 2 and slot3.order > 2 do
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

function slot0._onBackView(slot0)
	slot0._animator:Update(0)
	slot0._animator:Play("back", 0, 0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._treenodeList and #slot0._treenodeList > 0 then
		for slot4, slot5 in ipairs(slot0._treenodeList) do
			slot5.component:dispose()
		end

		slot0._treenodeList = nil
	end
end

return slot0
