module("modules.logic.survival.view.rewardinherit.SurvivalRewardInheritNpcSelectComp", package.seeall)

local var_0_0 = class("SurvivalRewardInheritNpcSelectComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.parentView = arg_1_1.parentView
	arg_1_0.refreshFunc = arg_1_1.refreshFunc
	arg_1_0.npcItem = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._txttips = gohelper.findChildText(arg_2_1, "layout/#txt_tips")
	arg_2_0._gogrid1 = gohelper.findChild(arg_2_1, "layout/#go_grid1")
	arg_2_0._goitem1 = gohelper.findChild(arg_2_1, "layout/#go_grid1/#go_item1")
	arg_2_0._goitem2 = gohelper.findChild(arg_2_1, "layout/#go_grid1/#go_item2")
	arg_2_0._gogrid2 = gohelper.findChild(arg_2_1, "layout/#go_grid2")
	arg_2_0._goitem3 = gohelper.findChild(arg_2_1, "layout/#go_grid2/#go_item3")
	arg_2_0._goitem4 = gohelper.findChild(arg_2_1, "layout/#go_grid2/#go_item4")
	arg_2_0.itemPos = {
		arg_2_0._goitem1,
		arg_2_0._goitem3,
		arg_2_0._goitem4
	}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.itemPos) do
		gohelper.setActive(iter_2_1, false)
	end

	arg_2_0.npcSelectMo = SurvivalRewardInheritModel.instance.npcSelectMo
end

function var_0_0.refreshInheritSelect(arg_3_0, arg_3_1, arg_3_2)
	gohelper.setActive(arg_3_0._gogrid1, true)
	gohelper.setActive(arg_3_0._gogrid2, arg_3_0.npcSelectMo.maxAmount > 2)

	for iter_3_0 = 1, arg_3_0.npcSelectMo.maxAmount do
		if arg_3_0.npcItem[iter_3_0] == nil then
			local var_3_0 = arg_3_0.parentView.viewContainer:getSetting().otherRes.survivalnpcheaditem
			local var_3_1 = arg_3_0.parentView:getResInst(var_3_0, arg_3_0.itemPos[iter_3_0])

			gohelper.setActive(arg_3_0.itemPos[iter_3_0], true)

			local var_3_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_3_1, SurvivalNpcHeadItem)

			arg_3_0.npcItem[iter_3_0] = var_3_2
		end

		local var_3_3
		local var_3_4 = arg_3_0.npcSelectMo.selectIdDic[iter_3_0]

		if var_3_4 then
			var_3_3 = SurvivalHandbookModel.instance:getMoById(var_3_4):getCellCfgId()
		end

		local var_3_5 = iter_3_0 == arg_3_2

		arg_3_0.npcItem[iter_3_0]:setData({
			isShowBtnRemove = true,
			isPlayPutEffect = true,
			isFirst = arg_3_1,
			pos = iter_3_0,
			npcId = var_3_3,
			onClickContext = arg_3_0,
			onClickBtnRemoveCallBack = arg_3_0.onClickBtnRemoveCallBack,
			isSelect = var_3_5
		})
	end
end

function var_0_0.onClickBtnRemoveCallBack(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.pos

	arg_4_0.npcSelectMo:removeOneByPos(var_4_0)
	arg_4_0.refreshFunc(arg_4_0.parentView)
end

return var_0_0
