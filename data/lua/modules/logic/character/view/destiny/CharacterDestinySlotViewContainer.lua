module("modules.logic.character.view.destiny.CharacterDestinySlotViewContainer", package.seeall)

local var_0_0 = class("CharacterDestinySlotViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CharacterDestinySlotView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.setCurDestinySlot(arg_3_0, arg_3_1)
	arg_3_0._destinySlot = arg_3_1
end

function var_0_0.playCloseTransition(arg_4_0)
	local var_4_0 = ZProj.ProjAnimatorPlayer.Get(arg_4_0.viewGO)
	local var_4_1 = arg_4_0._destinySlot and arg_4_0._destinySlot:isUnlockSlot() and CharacterDestinyEnum.SlotViewAnim.CloseUnlock or CharacterDestinyEnum.SlotViewAnim.CloseLock

	var_4_0:Play(var_4_1, arg_4_0.onCloseAnimDone, arg_4_0)
end

function var_0_0.onCloseAnimDone(arg_5_0)
	arg_5_0:onPlayCloseTransitionFinish()

	arg_5_0._destinySlot = nil
end

return var_0_0
