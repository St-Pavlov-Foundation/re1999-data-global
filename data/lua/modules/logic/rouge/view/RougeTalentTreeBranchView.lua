module("modules.logic.rouge.view.RougeTalentTreeBranchView", package.seeall)

local var_0_0 = class("RougeTalentTreeBranchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._tabIndex = arg_1_0.viewContainer:getTabView()._curTabId
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btnempty = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_empty")
	arg_1_0._treenodeList = {}
	arg_1_0._treeLightList = {}
	arg_1_0._curSelectId = nil
	arg_1_0._orderToDelayTime = {}
	arg_1_0._flexibleTime = 0.3

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, arg_2_0._refreshUI, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.OnClickTreeNode, arg_2_0._SelectItem, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.OnCancelTreeNode, arg_2_0.cancelSelectNode, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.onSwitchTab, arg_2_0._onSwitchTab, arg_2_0)
	arg_2_0._btnempty:AddClickListener(arg_2_0._btnemptyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, arg_3_0._refreshUI, arg_3_0)
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.OnClickTreeNode, arg_3_0._SelectItem, arg_3_0)
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.OnCancelTreeNode, arg_3_0.cancelSelectNode, arg_3_0)
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.onSwitchTab, arg_3_0._onSwitchTab, arg_3_0)
	arg_3_0._btnempty:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._btnemptyOnClick(arg_5_0)
	RougeController.instance:dispatchEvent(RougeEvent.OnClickEmpty, arg_5_0._tabIndex)
end

function var_0_0._refreshUI(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._treenodeList) do
		if arg_6_0._curSelectId == iter_6_1:getID() then
			if arg_6_1 and arg_6_1 == iter_6_1:getID() then
				iter_6_1:refreshItem(false, arg_6_1)
			else
				iter_6_1:refreshItem(true)
			end
		else
			iter_6_1:refreshItem(false)
		end
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0._treeLightList) do
		arg_6_0:_refreshLight(iter_6_3)
	end

	if arg_6_0._canplayAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.LightTalentBranch)

		arg_6_0._canplayAudio = false
	end
end

function var_0_0._onSwitchTab(arg_7_0, arg_7_1)
	if not (arg_7_0._tabIndex == arg_7_1) then
		gohelper.setActive(arg_7_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_7_0.viewGO, true)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._treeLightList) do
		if iter_7_1.isPlayAnim then
			iter_7_1.isPlayAnim = false

			gohelper.setActive(iter_7_1.go, false)
		end

		arg_7_0:_refreshLight(iter_7_1)
	end

	if arg_7_0._canplayAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.LightTalentBranch)

		arg_7_0._canplayAudio = false
	end
end

function var_0_0._SelectItem(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	local var_8_0 = arg_8_1.talent
	local var_8_1 = arg_8_1.id

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._treenodeList) do
		if arg_8_0._tabIndex == var_8_0 and iter_8_1:getID() == var_8_1 then
			if not arg_8_0._curSelectId then
				iter_8_1:refreshItem(true)

				arg_8_0._curSelectId = var_8_1
			elseif arg_8_0._currentSelectId ~= var_8_1 then
				iter_8_1:refreshItem(true)

				arg_8_0._curSelectId = var_8_1
			end
		else
			iter_8_1:refreshItem(false)
		end
	end
end

function var_0_0.cancelSelectNode(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._treenodeList) do
		if arg_9_1 == iter_9_1:getID() then
			iter_9_1:refreshItem(false)

			arg_9_0._curSelectId = nil

			break
		end
	end
end

function var_0_0.onOpen(arg_10_0)
	if not RougeTalentModel.instance:checkIsCurrentSelectView(arg_10_0._tabIndex) then
		return
	end

	arg_10_0._config = RougeTalentConfig.instance:getBranchConfigListByTalent(arg_10_0._tabIndex)
	arg_10_0._branchconfig = RougeTalentConfig.instance:getBranchLightConfigByTalent(arg_10_0._tabIndex)

	if not arg_10_0._branchconfig then
		logError("genuis_branch_light " .. arg_10_0._tabIndex .. " not config!!!!")
	end

	arg_10_0:_inititem()
	arg_10_0:_initLight()
end

function var_0_0._inititem(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._config) do
		local var_11_0 = arg_11_0._treenodeList[iter_11_0]

		if not var_11_0 then
			var_11_0 = arg_11_0:getUserDataTb_()

			local var_11_1 = string.gsub(iter_11_1.pos, "#", "_")
			local var_11_2 = gohelper.findChild(arg_11_0.viewGO, "item/#go_item" .. var_11_1)
			local var_11_3 = arg_11_0.viewContainer:getPoolView()

			if var_11_3 then
				var_11_0 = var_11_3:getIcon(var_11_2)
			end

			arg_11_0._treenodeList[iter_11_0] = var_11_0
		end

		var_11_0:initcomp(iter_11_1, arg_11_0._tabIndex)
		var_11_0:refreshItem()
	end
end

function var_0_0._initLight(arg_12_0)
	arg_12_0._canplayAudio = false

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._branchconfig) do
		local var_12_0 = arg_12_0._treeLightList[iter_12_0]

		if not var_12_0 then
			var_12_0 = arg_12_0:getUserDataTb_()

			local var_12_1 = gohelper.findChild(arg_12_0.viewGO, "light/" .. iter_12_1.lightname)
			local var_12_2 = var_12_1:GetComponent(typeof(UnityEngine.Animator))

			if iter_12_1.pos then
				local var_12_3 = {}

				if string.find(iter_12_1.pos, "|") then
					local var_12_4 = string.split(iter_12_1.pos, "|")

					for iter_12_2, iter_12_3 in ipairs(var_12_4) do
						local var_12_5 = string.splitToNumber(iter_12_3, "#")

						table.insert(var_12_3, var_12_5)
					end
				else
					local var_12_6 = string.splitToNumber(iter_12_1.pos, "#")

					table.insert(var_12_3, var_12_6)
				end

				if var_12_3 then
					var_12_0.posList = var_12_3
				end
			end

			var_12_0.index = iter_12_0
			var_12_0.name = iter_12_1.lightname
			var_12_0.go = var_12_1

			gohelper.setActive(var_12_0.go, false)

			var_12_0.animator = var_12_2
			var_12_0.talent = iter_12_1.talent
			var_12_0.order = iter_12_1.order
			var_12_0.allLight = arg_12_0:_checkCanLight(var_12_0)
			var_12_0.isPlayAnim = false

			local var_12_7 = var_12_0.animator.runtimeAnimatorController.animationClips

			for iter_12_4 = 0, var_12_7.Length - 1 do
				if var_12_7[iter_12_4].name:find("_light$") then
					var_12_0.animtime = var_12_7[iter_12_4].length
				end
			end
		end

		table.insert(arg_12_0._treeLightList, var_12_0)
		arg_12_0:_refreshLight(var_12_0)
	end

	if arg_12_0._canplayAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.LightTalentBranch)

		arg_12_0._canplayAudio = false
	end
end

function var_0_0._getDelayTime(arg_13_0, arg_13_1)
	local var_13_0 = 0
	local var_13_1 = arg_13_1.order

	if arg_13_0._orderToDelayTime[var_13_1] then
		return arg_13_0._orderToDelayTime[var_13_1]
	end

	local var_13_2

	for iter_13_0 = 1, #arg_13_0._treeLightList do
		if iter_13_0 > 1 and var_13_1 > 1 then
			local var_13_3 = arg_13_0._treeLightList[iter_13_0 - 1]

			if arg_13_0._orderToDelayTime[var_13_1 - 1] then
				var_13_0 = arg_13_0._orderToDelayTime[var_13_1 - 1] + arg_13_1.animtime - arg_13_0._flexibleTime

				break
			else
				var_13_0 = arg_13_1.animtime - arg_13_0._flexibleTime

				break
			end
		end
	end

	if var_13_0 > 0 then
		arg_13_0._orderToDelayTime[var_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0._checkCanLight(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.posList

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = 0

		for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
			if RougeTalentModel.instance:checkNodeLight(iter_14_3) then
				var_14_1 = var_14_1 + 1
			end
		end

		if var_14_1 == #iter_14_1 then
			return true
		end
	end

	return false
end

function var_0_0.onClose(arg_15_0)
	arg_15_0:recycleTreeNode()
end

function var_0_0.recycleTreeNode(arg_16_0)
	if arg_16_0._treenodeList then
		local var_16_0 = arg_16_0.viewContainer:getPoolView()

		for iter_16_0, iter_16_1 in ipairs(arg_16_0._treenodeList) do
			var_16_0:recycleIcon(arg_16_0._treenodeList[iter_16_0])

			arg_16_0._treenodeList[iter_16_0] = nil
		end
	end
end

function var_0_0._refreshLight(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:_getDelayTime(arg_17_1)
	local var_17_1 = arg_17_0:_checkCanLight(arg_17_1)

	function arg_17_0.playfunc(arg_18_0)
		if not arg_17_0.viewContainer or not arg_17_0.viewContainer._isVisible then
			return
		end

		TaskDispatcher.cancelTask(arg_17_0.playfunc, arg_18_0)
		gohelper.setActive(arg_18_0.go, true)
		arg_18_0.animator:Update(0)
		arg_18_0.animator:Play("light", 0, 0)

		arg_18_0.isPlayAnim = true
	end

	if not var_17_1 then
		gohelper.setActive(arg_17_1.go, false)
	elseif not arg_17_1.isPlayAnim then
		if arg_17_1.allLight then
			TaskDispatcher.runDelay(arg_17_0.playfunc, arg_17_1, var_17_0)

			arg_17_0._canplayAudio = true
		else
			local var_17_2 = arg_17_0:_checkBeforeBranchAllLightReturnDelayTime(arg_17_1)

			TaskDispatcher.runDelay(arg_17_0.playfunc, arg_17_1, var_17_2)

			arg_17_1.allLight = true
			arg_17_0._canplayAudio = true
		end
	end
end

function var_0_0._checkBeforeBranchAllLightReturnDelayTime(arg_19_0, arg_19_1)
	local var_19_0 = 0
	local var_19_1 = arg_19_1

	while var_19_1.index > 1 and var_19_1.order > 1 do
		var_19_0 = var_19_0 + arg_19_0:getBeforeLightAniTime(var_19_1)
		var_19_1 = arg_19_0._treeLightList[var_19_1.index - 1]
	end

	return var_19_0
end

function var_0_0.getBeforeLightAniTime(arg_20_0, arg_20_1)
	local var_20_0 = 0
	local var_20_1 = arg_20_0._treeLightList[arg_20_1.index - 1]

	if var_20_1.allLight and not var_20_1.isPlayAnim then
		var_20_0 = arg_20_1.animtime - arg_20_0._flexibleTime
	end

	return var_20_0
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0
