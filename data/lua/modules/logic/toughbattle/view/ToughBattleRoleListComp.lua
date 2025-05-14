module("modules.logic.toughbattle.view.ToughBattleRoleListComp", package.seeall)

local var_0_0 = class("ToughBattleRoleListComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.viewParam = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._anim = gohelper.findChild(arg_2_1, "root"):GetComponent(typeof(UnityEngine.Animator))

	local var_2_0 = gohelper.findChild(arg_2_1, "root/#go_rolelist")
	local var_2_1 = gohelper.findChild(var_2_0, "#go_item")

	arg_2_0._items = arg_2_0:getUserDataTb_()

	local var_2_2 = arg_2_0:getInfo()
	local var_2_3 = {}
	local var_2_4

	if arg_2_0.viewParam.mode == ToughBattleEnum.Mode.Act then
		var_2_4 = lua_activity158_challenge.configDict
	else
		var_2_4 = lua_siege_battle.configDict
	end

	for iter_2_0 = 1, 3 do
		local var_2_5 = var_2_4[var_2_2.passChallengeIds[iter_2_0]]
		local var_2_6 = var_2_5 and var_2_5.sort == arg_2_0.viewParam.lastFightSuccIndex

		var_2_3[iter_2_0] = {
			co = var_2_5,
			isNewGet = var_2_6
		}
	end

	gohelper.CreateObjList(arg_2_0, arg_2_0.createItem, var_2_3, var_2_0, var_2_1, ToughBattleRoleItem)
	arg_2_0:setSelect(arg_2_0._selectCo)
end

function var_0_0.getInfo(arg_3_0)
	return arg_3_0.viewParam.mode == ToughBattleEnum.Mode.Act and ToughBattleModel.instance:getActInfo() or ToughBattleModel.instance:getStoryInfo()
end

function var_0_0.createItem(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._items[arg_4_3] = arg_4_1

	arg_4_0._items[arg_4_3]:initData(arg_4_2)
	arg_4_0._items[arg_4_3]:setClickCallBack(arg_4_0._onItemClick, arg_4_0)
end

function var_0_0._onItemClick(arg_5_0, arg_5_1)
	if arg_5_0._clickCallBack then
		arg_5_0._clickCallBack(arg_5_0._callobj, arg_5_1)
	end
end

function var_0_0.setClickCallBack(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._clickCallBack = arg_6_1
	arg_6_0._callobj = arg_6_2
end

function var_0_0.setSelect(arg_7_0, arg_7_1)
	arg_7_0._selectCo = arg_7_1

	if arg_7_0._items then
		for iter_7_0 = 1, #arg_7_0._items do
			arg_7_0._items[iter_7_0]:setSelect(arg_7_1)
		end
	end
end

function var_0_0.playAnim(arg_8_0, arg_8_1)
	if not arg_8_0._anim then
		return
	end

	arg_8_0._anim:Play(arg_8_1, 0, 0)

	if arg_8_1 == "open" and arg_8_0._items then
		for iter_8_0 = 1, #arg_8_0._items do
			arg_8_0._items[iter_8_0]:playFirstAnim()
		end
	end
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0._clickCallBack = nil
	arg_9_0._callobj = nil
end

return var_0_0
