module("modules.logic.versionactivity2_2.lopera.view.LoperaSmeltResultView", package.seeall)

local var_0_0 = class("LoperaSmeltResultView", BaseView)
local var_0_1 = LoperaEnum.MapCfgIdx
local var_0_2 = VersionActivity2_2Enum.ActivityId.Lopera
local var_0_3 = "<color=#21631a>%s</color>"
local var_0_4 = {
	Done = 2,
	Smelting = 1
}
local var_0_5 = 2

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goStage1 = gohelper.findChild(arg_1_0.viewGO, "#go_Stage1")
	arg_1_0._goStage2 = gohelper.findChild(arg_1_0.viewGO, "#go_Stage2")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Stage2/#btn_Close")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "#go_Stage2/#scroll_List/Viewport/Content/#go_Item")
	arg_1_0._goItemRoot = gohelper.findChild(arg_1_0.viewGO, "#go_Stage2/#scroll_List/Viewport/Content")

	gohelper.setActive(arg_1_0._goItem, false)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0:addEventCb(LoperaController.instance, LoperaEvent.GoodItemClick, arg_2_0._onClickItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0.viewParam

	arg_5_0:changeViewStage(var_0_4.Smelting)
	TaskDispatcher.runDelay(arg_5_0.changeViewDoneStage, arg_5_0, var_0_5)
end

function var_0_0.refreshStageView(arg_6_0)
	gohelper.setActive(arg_6_0._goStage1, arg_6_0._curStage == var_0_4.Smelting)
	gohelper.setActive(arg_6_0._goStage2, arg_6_0._curStage == var_0_4.Done)

	if arg_6_0._curStage == var_0_4.Done then
		arg_6_0:refreshProductItems()
	end
end

function var_0_0.changeViewDoneStage(arg_7_0)
	arg_7_0:changeViewStage(var_0_4.Done)
end

function var_0_0.changeViewStage(arg_8_0, arg_8_1)
	arg_8_0._curStage = arg_8_1

	arg_8_0:refreshStageView()
end

function var_0_0.refreshProductItems(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = Activity168Model.instance:getItemChangeDict()

	if not var_9_1 then
		return
	end

	for iter_9_0, iter_9_1 in pairs(var_9_1) do
		if iter_9_1 > 0 then
			var_9_0[#var_9_0 + 1] = {
				id = iter_9_0,
				num = iter_9_1
			}
		end
	end

	gohelper.CreateObjList(arg_9_0, arg_9_0._createItem, var_9_0, arg_9_0._goItemRoot, arg_9_0._goItem, LoperaGoodsItem)
end

function var_0_0._createItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_2.id
	local var_10_1 = Activity168Config.instance:getGameItemCfg(var_0_2, var_10_0)

	arg_10_1:onUpdateData(var_10_1, arg_10_2.num, arg_10_3)
end

function var_0_0._onClickItem(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._tipsGo, true)

	local var_11_0 = gohelper.findChild(arg_11_0._goItemRoot, arg_11_1)
	local var_11_1 = arg_11_0._tipsGo.transform

	var_11_1:SetParent(var_11_0.transform, true)
	recthelper.setAnchorX(var_11_1, 320)
	recthelper.setAnchorY(var_11_1, -30)
	var_11_1:SetParent(arg_11_0.viewGO.transform, true)
	arg_11_0:_refreshGoodItemTips(arg_11_1)
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
