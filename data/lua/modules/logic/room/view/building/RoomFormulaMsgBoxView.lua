module("modules.logic.room.view.building.RoomFormulaMsgBoxView", package.seeall)

local var_0_0 = class("RoomFormulaMsgBoxView", BaseView)
local var_0_1 = -92.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._btnyes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_yes")
	arg_1_0._txtyes = gohelper.findChildText(arg_1_0.viewGO, "#btn_yes/yes")
	arg_1_0._btnno = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_no")
	arg_1_0._goScrollView = gohelper.findChild(arg_1_0.viewGO, "Exchange/Left/ScrollView")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "Exchange/Left/ScrollView/Viewport/Content")
	arg_1_0._contentGrid = arg_1_0._goContent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	arg_1_0._goPropItem = gohelper.findChild(arg_1_0.viewGO, "Exchange/Left/ScrollView/Viewport/Content/#go_PropItem")
	arg_1_0._gorightContent = gohelper.findChild(arg_1_0.viewGO, "Exchange/Right/ScrollView/Viewport/Content")
	arg_1_0._gorightPropItem = gohelper.findChild(arg_1_0.viewGO, "Exchange/Right/ScrollView/Viewport/Content/#go_PropItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnyes:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnyes:RemoveClickListener()
	arg_3_0._btnno:RemoveClickListener()
end

function var_0_0._btnyesOnClick(arg_4_0)
	if not arg_4_0.viewParam then
		return
	end

	local var_4_0 = RoomProductionModel.instance:getLineMO(arg_4_0.viewParam.lineId)
	local var_4_1 = arg_4_0.viewParam.callback

	if var_4_1 then
		var_4_1(arg_4_0.viewParam.callbackObj)
	end

	RoomRpc.instance:sendStartProductionLineRequest(var_4_0.id, arg_4_0.viewParam.costItemAndFormulaIdList.formulaIdList, arg_4_0.costItemList, arg_4_0.viewParam.combineCb, arg_4_0.viewParam.combineCbObj)
	arg_4_0:closeThis()
end

function var_0_0._btnnoOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._originalScrollViewPosX, arg_6_0._originalScrollViewPosY, _ = transformhelper.getLocalPos(arg_6_0._goScrollView.transform)

	gohelper.setActive(arg_6_0._goPropItem, false)
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
	arg_7_0:setMatItemList()
	arg_7_0:setProduceItemList()

	local var_7_0 = arg_7_0.viewParam.combineCb and "roomformula_combine_and_up" or "confirm_text"

	arg_7_0._txtyes.text = luaLang(var_7_0)
end

function var_0_0.setMatItemList(arg_8_0)
	arg_8_0.costItemList = {}
	arg_8_0._contentGrid.enabled = false

	local var_8_0 = arg_8_0.viewParam and arg_8_0.viewParam.costItemAndFormulaIdList.itemTypeDic

	if var_8_0 then
		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			for iter_8_2, iter_8_3 in pairs(iter_8_1) do
				if iter_8_3 > 0 then
					local var_8_1 = {
						type = iter_8_0,
						id = iter_8_2,
						quantity = iter_8_3
					}

					table.insert(arg_8_0.costItemList, var_8_1)
				end
			end
		end
	end

	RoomFormulaMsgBoxModel.instance:setCostItemList(arg_8_0.costItemList)

	if #RoomFormulaMsgBoxModel.instance:getList() <= arg_8_0.viewContainer.lineCount then
		transformhelper.setLocalPosXY(arg_8_0._goScrollView.transform, arg_8_0._originalScrollViewPosX, var_0_1)

		arg_8_0._contentGrid.enabled = true
	else
		arg_8_0._contentGrid.enabled = false

		transformhelper.setLocalPosXY(arg_8_0._goScrollView.transform, arg_8_0._originalScrollViewPosX, arg_8_0._originalScrollViewPosY)
	end
end

function var_0_0.setProduceItemList(arg_9_0)
	arg_9_0.produceItemList = {}

	local var_9_0 = arg_9_0.viewParam and arg_9_0.viewParam.produceDataList or {}

	gohelper.CreateObjList(arg_9_0, arg_9_0._onCreateProduceItem, var_9_0, arg_9_0._gorightContent, arg_9_0._gorightPropItem, RoomFormulaMsgBoxItem)

	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_2 = ItemModel.instance:getItemConfigAndIcon(iter_9_1.type, iter_9_1.id)
		local var_9_3 = GameUtil.numberDisplay(iter_9_1.quantity)
		local var_9_4 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("multiple_2"), var_9_2.name, var_9_3)

		var_9_1[#var_9_1 + 1] = var_9_4
	end

	local var_9_5 = luaLang("comma_sep")
	local var_9_6 = table.concat(var_9_1, var_9_5)

	arg_9_0._txtdesc.text = formatLuaLang("room_formula_easy_combine_msg_box_tip", var_9_6)
end

function var_0_0._onCreateProduceItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_1:onUpdateMO(arg_10_2)

	arg_10_0.produceItemList[arg_10_3] = arg_10_1
end

function var_0_0.onClose(arg_11_0)
	return
end

return var_0_0
