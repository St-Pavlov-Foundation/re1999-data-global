module("modules.logic.fight.view.magiccircle.work.FightMagicCircleRemoveWork", package.seeall)

local var_0_0 = class("FightMagicCircleRemoveWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.magicItem = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	if arg_2_0.magicItem then
		arg_2_0.magicItem:playAnim("close", arg_2_0.onCloseAnimDone, arg_2_0)
	else
		arg_2_0:onCloseAnimDone()
	end
end

function var_0_0.onCloseAnimDone(arg_3_0)
	if arg_3_0.magicItem then
		arg_3_0.magicItem:onRemoveMagic()
	end

	arg_3_0:onDone(true)
end

function var_0_0.onDestroy(arg_4_0)
	if arg_4_0.magicItem then
		arg_4_0.magicItem:onRemoveMagic()
	end

	arg_4_0.magicItem = nil
end

return var_0_0
