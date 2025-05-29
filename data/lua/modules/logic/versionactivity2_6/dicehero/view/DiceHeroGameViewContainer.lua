module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroGameViewContainer", package.seeall)

local var_0_0 = class("DiceHeroGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	DiceHeroStatHelper.instance:resetGameDt()

	DiceHeroModel.instance.guideLevel = DiceHeroModel.instance.lastEnterLevelId

	return {
		DiceHeroGameView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
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
	if DiceHeroFightModel.instance.finishResult ~= DiceHeroEnum.GameStatu.None then
		return
	end

	local var_3_0 = DiceHeroModel.instance.lastEnterLevelId
	local var_3_1 = lua_dice_level.configDict[var_3_0]

	if var_3_1 then
		local var_3_2 = DiceHeroModel.instance:getGameInfo(var_3_1.chapter)

		if var_3_2.currLevel ~= var_3_0 or var_3_2.allPass then
			return arg_3_0:statAndClose()
		end
	else
		return arg_3_0:closeThis()
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DiceHeroExitFight, MsgBoxEnum.BoxType.Yes_No, arg_3_0.statAndClose, nil, nil, arg_3_0)
end

function var_0_0.statAndClose(arg_4_0)
	DiceHeroStatHelper.instance:sendFightEnd(nil, nil)
	arg_4_0:closeThis()
end

return var_0_0
