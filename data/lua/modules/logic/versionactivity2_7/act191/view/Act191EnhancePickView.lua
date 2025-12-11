module("modules.logic.versionactivity2_7.act191.view.Act191EnhancePickView", package.seeall)

local var_0_0 = class("Act191EnhancePickView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSelectItem = gohelper.findChild(arg_1_0.viewGO, "scroll_view/Viewport/Content/#go_SelectItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function Act174ForcePickView._onEscBtnClick(arg_2_0)
	return
end

function var_0_0._editableInitView(arg_3_0)
	gohelper.setActive(arg_3_0._goSelectItem, false)

	arg_3_0.actId = Activity191Model.instance:getCurActId()
	arg_3_0.maxFreshNum = tonumber(lua_activity191_const.configDict[Activity191Enum.ConstKey.MaxFreshNum].value)
end

function var_0_0.onUpdateParam(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.nodeDetailMo = arg_5_0.viewParam
	arg_5_0.enhanceItemList = {}

	arg_5_0:refreshUI()
end

function var_0_0.refreshUI(arg_6_0)
	arg_6_0.freshIndex = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.nodeDetailMo.enhanceList) do
		local var_6_0 = arg_6_0.enhanceItemList[iter_6_0] or arg_6_0:creatEnhanceItem(iter_6_0)
		local var_6_1 = Activity191Config.instance:getEnhanceCo(arg_6_0.actId, iter_6_1)

		var_6_0.buffIcon:LoadImage(ResUrl.getAct174BuffIcon(var_6_1.icon))

		var_6_0.txtName.text = var_6_1.title

		local var_6_2 = SkillHelper.addLink(var_6_1.desc)
		local var_6_3 = string.splitToNumber(var_6_1.effects, "|")[1]
		local var_6_4 = lua_activity191_effect.configDict[var_6_3]

		if var_6_4 then
			if var_6_4.type == Activity191Enum.EffectType.EnhanceHero then
				var_6_0.txtDesc.text = Activity191Helper.buildDesc(var_6_2, Activity191Enum.HyperLinkPattern.EnhanceDestiny, var_6_4.typeParam)

				SkillHelper.addHyperLinkClick(var_6_0.txtDesc, Activity191Helper.clickHyperLinkDestiny)
			elseif var_6_4.type == Activity191Enum.EffectType.Item then
				var_6_0.txtDesc.text = Activity191Helper.buildDesc(var_6_2, Activity191Enum.HyperLinkPattern.EnhanceItem, var_6_4.typeParam .. "#")

				SkillHelper.addHyperLinkClick(var_6_0.txtDesc, Activity191Helper.clickHyperLinkItem)
			elseif var_6_4.type == Activity191Enum.EffectType.Hero then
				var_6_0.txtDesc.text = Activity191Helper.buildDesc(var_6_2, Activity191Enum.HyperLinkPattern.Hero, var_6_4.typeParam)

				SkillHelper.addHyperLinkClick(var_6_0.txtDesc, Activity191Helper.clickHyperLinkRole)
			else
				var_6_0.txtDesc.text = var_6_2
			end
		else
			var_6_0.txtDesc.text = var_6_2
		end

		local var_6_5 = arg_6_0.nodeDetailMo.enhanceNumList[iter_6_0] or 0

		gohelper.setActive(var_6_0.btnFresh, var_6_5 < arg_6_0.maxFreshNum)
	end
end

function var_0_0.creatEnhanceItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getUserDataTb_()
	local var_7_1 = gohelper.cloneInPlace(arg_7_0._goSelectItem, "enhanceItem" .. arg_7_1)

	var_7_0.anim = var_7_1:GetComponent(gohelper.Type_Animator)
	var_7_0.buffIcon = gohelper.findChildSingleImage(var_7_1, "simage_bufficon")
	var_7_0.txtName = gohelper.findChildText(var_7_1, "txt_name")
	var_7_0.txtDesc = gohelper.findChildText(var_7_1, "scroll_desc/Viewport/go_desccontent/txt_desc")

	local var_7_2 = gohelper.findChildButtonWithAudio(var_7_1, "btn_select")

	arg_7_0:addClickCb(var_7_2, arg_7_0.clickBuy, arg_7_0, arg_7_1)

	var_7_0.btnFresh = gohelper.findChildButtonWithAudio(var_7_1, "btn_Fresh")

	arg_7_0:addClickCb(var_7_0.btnFresh, arg_7_0.clickFresh, arg_7_0, arg_7_1)

	arg_7_0.enhanceItemList[arg_7_1] = var_7_0

	gohelper.setActive(var_7_1, true)

	return var_7_0
end

function var_0_0.clickBuy(arg_8_0, arg_8_1)
	if arg_8_0.selectIndex then
		return
	end

	arg_8_0.selectIndex = arg_8_1

	Activity191Rpc.instance:sendSelect191EnhanceRequest(arg_8_0.actId, arg_8_1, arg_8_0.onSelectEnhance, arg_8_0)
end

function var_0_0.clickFresh(arg_9_0, arg_9_1)
	if arg_9_0.freshIndex then
		return
	end

	arg_9_0.freshIndex = arg_9_1

	Activity191Rpc.instance:sendFresh191EnhanceRequest(arg_9_0.actId, arg_9_1, arg_9_0.onFreshEnhance, arg_9_0)
end

function var_0_0.onSelectEnhance(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 == 0 then
		local var_10_0 = arg_10_0.enhanceItemList[arg_10_0.selectIndex]

		if var_10_0 then
			var_10_0.anim:Play(UIAnimationName.Close)
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_reset)
		end

		TaskDispatcher.runDelay(arg_10_0.delayClose, arg_10_0, 0.67)
	end
end

function var_0_0.delayClose(arg_11_0)
	arg_11_0.selectIndex = nil

	if not Activity191Controller.instance:checkOpenGetView() then
		Activity191Controller.instance:nextStep()
	end

	arg_11_0:closeThis()
end

function var_0_0.onFreshEnhance(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 == 0 then
		if arg_12_0.freshIndex then
			arg_12_0.enhanceItemList[arg_12_0.freshIndex].anim:Play("switch", 0, 0)
		end

		arg_12_0.nodeDetailMo = Activity191Model.instance:getActInfo():getGameInfo():getNodeDetailMo()

		TaskDispatcher.runDelay(arg_12_0.refreshUI, arg_12_0, 0.16)
	end
end

function var_0_0.onDestroyView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.delayClose, arg_13_0)
end

return var_0_0
