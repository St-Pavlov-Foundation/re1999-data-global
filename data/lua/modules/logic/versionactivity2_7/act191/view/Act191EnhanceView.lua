module("modules.logic.versionactivity2_7.act191.view.Act191EnhanceView", package.seeall)

local var_0_0 = class("Act191EnhanceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclosetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closetip")
	arg_1_0._goscrolltips = gohelper.findChild(arg_1_0.viewGO, "#go_scrolltips")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#go_scrolltips/viewport/content/go_title/#txt_title")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_scrolltips/viewport/content/go_title/#image_icon")
	arg_1_0._goskillitem = gohelper.findChild(arg_1_0.viewGO, "#go_scrolltips/viewport/content/#go_skillitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosetip:AddClickListener(arg_2_0._btnclosetipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosetip:RemoveClickListener()
end

function var_0_0._btnclosetipOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.actId = Activity191Model.instance:getCurActId()
	arg_5_0._goContent = gohelper.findChild(arg_5_0.viewGO, "#go_scrolltips/viewport/content")
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)

	if not arg_6_0.viewParam then
		return
	end

	arg_6_0.enhanceIds = Activity191Model.instance:getActInfo():getGameInfo().warehouseInfo.enhanceId

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.enhanceIds) do
		local var_6_0 = gohelper.cloneInPlace(arg_6_0._goskillitem)
		local var_6_1 = Activity191Config.instance:getEnhanceCo(arg_6_0.actId, iter_6_1)

		if var_6_1 then
			local var_6_2 = gohelper.findChildText(var_6_0, "txt_skill")
			local var_6_3 = gohelper.findChildSingleImage(var_6_0, "skillicon")

			var_6_2.text = var_6_1.desc

			var_6_3:LoadImage(ResUrl.getAct174BuffIcon(var_6_1.icon))

			local var_6_4 = SkillHelper.addLink(var_6_1.desc)
			local var_6_5 = string.splitToNumber(var_6_1.effects, "|")[1]
			local var_6_6 = lua_activity191_effect.configDict[var_6_5]

			if var_6_6 then
				if var_6_6.type == Activity191Enum.EffectType.EnhanceHero then
					var_6_2.text = Activity191Helper.buildDesc(var_6_4, Activity191Enum.HyperLinkPattern.EnhanceDestiny, var_6_6.typeParam)

					SkillHelper.addHyperLinkClick(var_6_2, Activity191Helper.clickHyperLinkDestiny)
				elseif var_6_6.type == Activity191Enum.EffectType.Item then
					var_6_2.text = Activity191Helper.buildDesc(var_6_4, Activity191Enum.HyperLinkPattern.EnhanceItem, var_6_6.typeParam .. "#")

					SkillHelper.addHyperLinkClick(var_6_2, Activity191Helper.clickHyperLinkItem)
				elseif var_6_6.type == Activity191Enum.EffectType.Hero then
					var_6_2.text = Activity191Helper.buildDesc(var_6_4, Activity191Enum.HyperLinkPattern.Hero, var_6_6.typeParam)

					SkillHelper.addHyperLinkClick(var_6_2, Activity191Helper.clickHyperLinkRole)
				else
					var_6_2.text = var_6_4
				end
			else
				var_6_2.text = var_6_4
			end
		end
	end

	gohelper.setActive(arg_6_0._goskillitem, false)
	TaskDispatcher.runDelay(arg_6_0.refreshAnchor, arg_6_0, 0.01)
end

function var_0_0.refreshAnchor(arg_7_0)
	local var_7_0 = arg_7_0._goscrolltips.transform
	local var_7_1 = recthelper.getHeight(var_7_0)
	local var_7_2 = recthelper.getHeight(arg_7_0._goContent.transform)
	local var_7_3 = var_7_1 < var_7_2 and var_7_1 or var_7_2
	local var_7_4 = arg_7_0.viewParam.pos

	if arg_7_0.viewParam.isDown then
		recthelper.setAnchor(var_7_0, var_7_4.x, var_7_4.y + var_7_3)
	else
		recthelper.setAnchor(var_7_0, var_7_4.x, var_7_4.y)
	end
end

function var_0_0.onDestroyView(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.refreshAnchor, arg_8_0)
end

return var_0_0
