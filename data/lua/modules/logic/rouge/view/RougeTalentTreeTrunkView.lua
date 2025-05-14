module("modules.logic.rouge.view.RougeTalentTreeTrunkView", package.seeall)

local var_0_0 = class("RougeTalentTreeTrunkView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simageallfininshedlight = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_allfininshed_light")
	arg_1_0._btnoverview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_overview")
	arg_1_0._gotoprighttips = gohelper.findChild(arg_1_0.viewGO, "#go_topright/tips")
	arg_1_0._txttoprighttips = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/tips/#txt_tips")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#txt_num")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_click")
	arg_1_0._btnempty = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_empty")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._treenodeList = {}
	arg_1_0._treeLightList = {}
	arg_1_0._orderToDelayTime = {}
	arg_1_0._orderToLightList = {}
	arg_1_0._flexibleTime = 0.2

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnoverview:AddClickListener(arg_2_0._btnoverviewOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnempty:AddClickListener(arg_2_0._btnclickEmpty, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, arg_2_0._refreshUI, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.enterTalentView, arg_2_0._onClickTalentTreeItem, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.reallyExitTalentView, arg_2_0._onBackView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnoverview:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnempty:RemoveClickListener()
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, arg_3_0._refreshUI, arg_3_0)
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.enterTalentView, arg_3_0._onClickTalentTreeItem, arg_3_0)
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.reallyExitTalentView, arg_3_0._onBackView, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._season = RougeOutsideModel.instance:season()

	local var_4_0 = 999

	arg_4_0._config = RougeTalentConfig.instance:getRougeTalentDict(arg_4_0._season)
	arg_4_0._lightconfig = RougeTalentConfig.instance:getBranchLightConfigByTalent(var_4_0)
end

function var_0_0._refreshUI(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._treenodeList) do
		iter_5_1.component:refreshItem()
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0._treeLightList) do
		arg_5_0:_refreshLight(iter_5_3)
	end

	arg_5_0._txtnum.text = RougeTalentModel.instance:getTalentPoint()

	local var_5_0 = RougeConfig.instance:getOutSideConstValueByID(RougeEnum.OutsideConst.SkillPointLimit)
	local var_5_1 = RougeTalentModel.instance:getHadAllTalentPoint()
	local var_5_2 = {
		var_5_1,
		var_5_0
	}

	arg_5_0._txttoprighttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_talenttree_remaintalent"), var_5_2)
end

function var_0_0._btnclickOnClick(arg_6_0)
	arg_6_0._isopentips = not arg_6_0._isopentips

	gohelper.setActive(arg_6_0._gotoprighttips, arg_6_0._isopentips)
end

function var_0_0._btnclickEmpty(arg_7_0)
	if arg_7_0._isopentips then
		arg_7_0._isopentips = false

		gohelper.setActive(arg_7_0._gotoprighttips, arg_7_0._isopentips)
	end
end

function var_0_0.onOpen(arg_8_0)
	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(arg_8_0._season)
	RougeOutsideRpc.instance:sendRougeMarkGeniusNewStageRequest(arg_8_0._season)
	AudioMgr.instance:trigger(AudioEnum.UI.OpenTalentTrunkTreeView)

	arg_8_0._txtnum.text = RougeTalentModel.instance:getTalentPoint()

	arg_8_0:_initItem()
	arg_8_0:_initLight()
end

function var_0_0._initItem(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._config) do
		if not arg_9_0._treenodeList[iter_9_0] then
			local var_9_0 = arg_9_0:getUserDataTb_()
			local var_9_1 = gohelper.findChild(arg_9_0.viewGO, "item/#go_item" .. iter_9_0)
			local var_9_2 = arg_9_0.viewContainer:getSetting().otherRes.branchitem
			local var_9_3 = arg_9_0:getResInst(var_9_2, var_9_1, "treenode" .. tostring(iter_9_0))
			local var_9_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_3, RougeTalentTreeItem)

			var_9_4:initcomp(var_9_3, iter_9_1, iter_9_0)

			var_9_0.go = var_9_3
			var_9_0.component = var_9_4
			arg_9_0._treenodeList[iter_9_0] = var_9_0
		end
	end
end

function var_0_0._initLight(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._lightconfig) do
		local var_10_0 = arg_10_0._treeLightList[iter_10_0]

		if not var_10_0 then
			var_10_0 = arg_10_0:getUserDataTb_()

			local var_10_1 = gohelper.findChild(arg_10_0.viewGO, "light/" .. iter_10_1.lightname)

			if not var_10_1 then
				logError("genuis_branch_light " .. arg_10_0._tabIndex .. " not config!!!!")
			end

			local var_10_2 = var_10_1:GetComponent(typeof(UnityEngine.Animator))

			if iter_10_1.pos then
				local var_10_3 = {}
				local var_10_4 = string.splitToNumber(iter_10_1.pos, "|")

				if var_10_4 then
					var_10_0.posList = var_10_4
				end
			end

			var_10_0.name = iter_10_1.lightname
			var_10_0.go = var_10_1
			var_10_0.index = iter_10_0

			gohelper.setActive(var_10_0.go, false)

			var_10_0.animator = var_10_2
			var_10_0.talent = iter_10_1.talent
			var_10_0.order = iter_10_1.order
			var_10_0.allLight = arg_10_0:_checkCanLight(var_10_0)
			var_10_0.isPlayAnim = false

			if var_10_2 then
				local var_10_5 = var_10_0.animator.runtimeAnimatorController.animationClips

				for iter_10_2 = 0, var_10_5.Length - 1 do
					if var_10_5[iter_10_2].name:find("_light$") then
						var_10_0.animtime = var_10_5[iter_10_2].length
						var_10_0.animCilp = var_10_5[iter_10_2]
					end
				end
			end
		end

		table.insert(arg_10_0._treeLightList, var_10_0)

		if not arg_10_0._orderToLightList[iter_10_1.order] then
			arg_10_0._orderToLightList[iter_10_1.order] = {}
		end

		table.insert(arg_10_0._orderToLightList[iter_10_1.order], var_10_0)
	end

	for iter_10_3, iter_10_4 in ipairs(arg_10_0._treeLightList) do
		arg_10_0:_refreshLight(iter_10_4)
	end
end

function var_0_0._checkCanLight(arg_11_0, arg_11_1)
	if arg_11_1.order == 1 then
		return true
	end

	local var_11_0 = arg_11_1.posList

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if not RougeTalentModel.instance:checkBigNodeLock(iter_11_1) then
			return true
		end
	end

	return false
end

function var_0_0._getDelayTime(arg_12_0, arg_12_1)
	if not arg_12_1.animator then
		return 0
	end

	local var_12_0 = 0
	local var_12_1 = arg_12_1.order

	if arg_12_0._orderToDelayTime[var_12_1] then
		return arg_12_0._orderToDelayTime[var_12_1]
	end

	local var_12_2

	for iter_12_0 = 1, #arg_12_0._treeLightList do
		if iter_12_0 > 1 and var_12_1 > 1 then
			local var_12_3 = arg_12_0._treeLightList[iter_12_0 - 1]

			if arg_12_0._orderToDelayTime[var_12_1 - 1] then
				var_12_0 = arg_12_0._orderToDelayTime[var_12_1 - 1] + arg_12_1.animtime - arg_12_0._flexibleTime

				break
			else
				var_12_0 = arg_12_1.animtime - arg_12_0._flexibleTime

				break
			end
		end
	end

	if var_12_0 > 0 then
		arg_12_0._orderToDelayTime[var_12_1] = var_12_0
	end

	return var_12_0
end

function var_0_0._btnoverviewOnClick(arg_13_0)
	ViewMgr.instance:openView(ViewName.RougeTalentTreeOverview)
end

function var_0_0._onClickTalentTreeItem(arg_14_0, arg_14_1)
	if arg_14_0._inAnim then
		return
	end

	arg_14_0._inAnim = true

	arg_14_0._animator:Update(0)
	arg_14_0._animator:Play("click", 0, 0)

	local var_14_0 = 0.5

	function arg_14_0._openCallBack()
		TaskDispatcher.cancelTask(arg_14_0._openCallBack, arg_14_0)

		arg_14_0._inAnim = false

		RougeTalentModel.instance:setCurrentSelectIndex(arg_14_1)
		ViewMgr.instance:openView(ViewName.RougeTalentTreeView, arg_14_1)
	end

	TaskDispatcher.runDelay(arg_14_0._openCallBack, arg_14_0, var_14_0)
end

function var_0_0._refreshLight(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:_checkCanLight(arg_16_1)
	local var_16_1 = RougeTalentModel.instance:getNextNeedUnlockTalent()
	local var_16_2 = false

	if not var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_1) do
			for iter_16_2, iter_16_3 in ipairs(arg_16_1.posList) do
				if iter_16_1 == iter_16_3 then
					var_16_2 = true

					break
				end
			end
		end

		if not var_16_2 then
			gohelper.setActive(arg_16_1.go, false)
		else
			local var_16_3 = arg_16_0:_getLightPer(arg_16_1)

			if var_16_3 > 0 then
				gohelper.setActive(arg_16_1.go, true)
				arg_16_1.animator:Update(0)
				arg_16_1.animator:Play("light", 0, var_16_3 * arg_16_1.animtime)

				arg_16_1.animator.speed = 0
			else
				gohelper.setActive(arg_16_1.go, false)
			end
		end
	else
		gohelper.setActive(arg_16_1.go, true)
		arg_16_1.animator:Update(0)
		arg_16_1.animator:Play("idle", 0, 0)
	end
end

function var_0_0._getLightPer(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._orderToLightList[arg_17_1.order - 1]
	local var_17_1
	local var_17_2 = 0
	local var_17_3 = 0

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if #iter_17_1.posList == 0 then
			var_17_1 = iter_17_1

			break
		end

		for iter_17_2, iter_17_3 in ipairs(iter_17_1.posList) do
			if var_17_2 < iter_17_3 then
				var_17_2 = iter_17_3
				var_17_3 = iter_17_2
				var_17_1 = iter_17_1
			end
		end
	end

	local var_17_4 = RougeOutsideModel.instance:season()
	local var_17_5 = var_17_1.posList[var_17_3] or 1
	local var_17_6 = RougeTalentConfig.instance:getConfigByTalent(var_17_4, var_17_5)
	local var_17_7 = RougeTalentConfig.instance:getConfigByTalent(var_17_4, arg_17_1.posList[1])
	local var_17_8 = RougeTalentModel.instance:getHadAllTalentPoint()
	local var_17_9 = var_17_6.cost or 0

	return (var_17_8 - var_17_9) / (var_17_7.cost - var_17_9)
end

function var_0_0._checkBeforeBranchAllLightReturnDelayTime(arg_18_0, arg_18_1)
	local var_18_0 = 0
	local var_18_1 = arg_18_1

	while var_18_1.index > 2 and var_18_1.order > 2 do
		var_18_0 = var_18_0 + arg_18_0:getBeforeLightAniTime(var_18_1)
		var_18_1 = arg_18_0._treeLightList[var_18_1.index - 1]
	end

	return var_18_0
end

function var_0_0.getBeforeLightAniTime(arg_19_0, arg_19_1)
	local var_19_0 = 0
	local var_19_1 = arg_19_0._treeLightList[arg_19_1.index - 1]

	if var_19_1.allLight and not var_19_1.isPlayAnim then
		var_19_0 = arg_19_1.animtime - arg_19_0._flexibleTime
	end

	return var_19_0
end

function var_0_0._onBackView(arg_20_0)
	arg_20_0._animator:Update(0)
	arg_20_0._animator:Play("back", 0, 0)
end

function var_0_0.onClose(arg_21_0)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	if arg_22_0._treenodeList and #arg_22_0._treenodeList > 0 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._treenodeList) do
			iter_22_1.component:dispose()
		end

		arg_22_0._treenodeList = nil
	end
end

return var_0_0
