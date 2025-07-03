module("modules.logic.versionactivity2_7.act191.view.Act191EnhancePickView", package.seeall)

local var_0_0 = class("Act191EnhancePickView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSelectItem = gohelper.findChild(arg_1_0.viewGO, "scroll_view/Viewport/Content/#go_SelectItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function Act174ForcePickView._onEscBtnClick(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._goSelectItem, false)

	arg_5_0.actId = Activity191Model.instance:getCurActId()
	arg_5_0.maxFreshNum = tonumber(lua_activity191_const.configDict[Activity191Enum.ConstKey.MaxFreshNum].value)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.nodeDetailMo = arg_7_0.viewParam
	arg_7_0.enhanceItemList = {}

	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0.freshIndex = nil

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.nodeDetailMo.enhanceList) do
		local var_8_0 = arg_8_0.enhanceItemList[iter_8_0] or arg_8_0:creatEnhanceItem(iter_8_0)
		local var_8_1 = Activity191Config.instance:getEnhanceCo(arg_8_0.actId, iter_8_1)

		var_8_0.buffIcon:LoadImage(ResUrl.getAct174BuffIcon(var_8_1.icon))

		var_8_0.txtName.text = var_8_1.title

		local var_8_2 = SkillHelper.addLink(var_8_1.desc)
		local var_8_3 = string.splitToNumber(var_8_1.effects, "|")[1]
		local var_8_4 = lua_activity191_effect.configDict[var_8_3]

		if var_8_4 then
			if var_8_4.type == Activity191Enum.EffectType.EnhanceHero then
				var_8_0.txtDesc.text = Activity191Helper.buildDesc(var_8_2, Activity191Enum.HyperLinkPattern.EnhanceDestiny, var_8_4.typeParam)

				SkillHelper.addHyperLinkClick(var_8_0.txtDesc, Activity191Helper.clickHyperLinkDestiny)
			elseif var_8_4.type == Activity191Enum.EffectType.EnhanceItem then
				var_8_0.txtDesc.text = Activity191Helper.buildDesc(var_8_2, Activity191Enum.HyperLinkPattern.EnhanceItem, var_8_4.typeParam .. "#")

				SkillHelper.addHyperLinkClick(var_8_0.txtDesc, Activity191Helper.clickHyperLinkItem)
			else
				var_8_0.txtDesc.text = var_8_2
			end
		else
			var_8_0.txtDesc.text = var_8_2
		end

		local var_8_5 = arg_8_0.nodeDetailMo.enhanceNumList[iter_8_0] or 0

		gohelper.setActive(var_8_0.btnFresh, var_8_5 < arg_8_0.maxFreshNum)
	end
end

function var_0_0.creatEnhanceItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getUserDataTb_()
	local var_9_1 = gohelper.cloneInPlace(arg_9_0._goSelectItem, "enhanceItem" .. arg_9_1)

	var_9_0.anim = var_9_1:GetComponent(gohelper.Type_Animator)
	var_9_0.buffIcon = gohelper.findChildSingleImage(var_9_1, "simage_bufficon")
	var_9_0.txtName = gohelper.findChildText(var_9_1, "txt_name")
	var_9_0.txtDesc = gohelper.findChildText(var_9_1, "scroll_desc/Viewport/go_desccontent/txt_desc")

	local var_9_2 = gohelper.findChildButtonWithAudio(var_9_1, "btn_select")

	arg_9_0:addClickCb(var_9_2, arg_9_0.clickBuy, arg_9_0, arg_9_1)

	var_9_0.btnFresh = gohelper.findChildButtonWithAudio(var_9_1, "btn_Fresh")

	arg_9_0:addClickCb(var_9_0.btnFresh, arg_9_0.clickFresh, arg_9_0, arg_9_1)

	arg_9_0.enhanceItemList[arg_9_1] = var_9_0

	gohelper.setActive(var_9_1, true)

	return var_9_0
end

function var_0_0.clickBuy(arg_10_0, arg_10_1)
	if arg_10_0.selectIndex then
		return
	end

	arg_10_0.selectIndex = arg_10_1

	Activity191Rpc.instance:sendSelect191EnhanceRequest(arg_10_0.actId, arg_10_1, arg_10_0.onSelectEnhance, arg_10_0)
end

function var_0_0.clickFresh(arg_11_0, arg_11_1)
	if arg_11_0.freshIndex then
		return
	end

	arg_11_0.freshIndex = arg_11_1

	Activity191Rpc.instance:sendFresh191EnhanceRequest(arg_11_0.actId, arg_11_1, arg_11_0.onFreshEnhance, arg_11_0)
end

function var_0_0.onSelectEnhance(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 == 0 then
		local var_12_0 = arg_12_0.enhanceItemList[arg_12_0.selectIndex]

		if var_12_0 then
			var_12_0.anim:Play(UIAnimationName.Close)
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_reset)
		end

		TaskDispatcher.runDelay(arg_12_0.delayClose, arg_12_0, 0.67)
	end
end

function var_0_0.delayClose(arg_13_0)
	arg_13_0.selectIndex = nil

	if not Activity191Controller.instance:checkOpenGetView() then
		Activity191Controller.instance:nextStep()
	end

	arg_13_0:closeThis()
end

function var_0_0.onFreshEnhance(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 == 0 then
		if arg_14_0.freshIndex then
			arg_14_0.enhanceItemList[arg_14_0.freshIndex].anim:Play("switch", 0, 0)
		end

		arg_14_0.nodeDetailMo = Activity191Model.instance:getActInfo():getGameInfo():getNodeDetailMo()

		TaskDispatcher.runDelay(arg_14_0.refreshUI, arg_14_0, 0.16)
	end
end

function var_0_0.onDestroyView(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.delayClose, arg_15_0)
end

return var_0_0
