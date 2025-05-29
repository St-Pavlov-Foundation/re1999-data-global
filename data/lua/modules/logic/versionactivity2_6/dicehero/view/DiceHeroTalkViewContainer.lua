module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroTalkViewContainer", package.seeall)

local var_0_0 = class("DiceHeroTalkViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {
		DiceHeroTalkView.New()
	}

	DiceHeroStatHelper.instance:resetTalkDt()

	DiceHeroModel.instance.guideLevel = arg_1_0.viewParam.co.id

	if arg_1_0.viewParam.co.type == DiceHeroEnum.LevelType.Story then
		table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))
	end

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		var_2_0:setOverrideClose(arg_2_0.defaultOverrideCloseClick, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0.defaultOverrideCloseClick(arg_3_0)
	local var_3_0 = arg_3_0.viewParam.co
	local var_3_1 = DiceHeroModel.instance:getGameInfo(var_3_0.chapter)

	if var_3_1.currLevel == var_3_0.id and not var_3_1.allPass then
		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DiceHeroExitFight, MsgBoxEnum.BoxType.Yes_No, arg_3_0.statAndClose, nil, nil, arg_3_0)
	else
		arg_3_0:statAndClose()
	end
end

function var_0_0.statAndClose(arg_4_0)
	DiceHeroStatHelper.instance:sendStoryEnd(false, false)
	arg_4_0:closeThis()
end

return var_0_0
