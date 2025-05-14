module("modules.logic.room.view.building.RoomFormulaMsgBoxView", package.seeall)

local var_0_0 = class("RoomFormulaMsgBoxView", BaseView)
local var_0_1 = -92.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._btnyes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_yes")
	arg_1_0._btnno = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_no")
	arg_1_0._goScrollView = gohelper.findChild(arg_1_0.viewGO, "Exchange/Left/Scroll View")
	arg_1_0._originalScrollViewPosX, arg_1_0._originalScrollViewPosY, _ = transformhelper.getLocalPos(arg_1_0._goScrollView.transform)
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "Exchange/Left/Scroll View/Viewport/Content")
	arg_1_0._contentGrid = arg_1_0._goContent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	arg_1_0._goPropItem = gohelper.findChild(arg_1_0.viewGO, "Exchange/Left/Scroll View/Viewport/Content/#go_PropItem")

	gohelper.setActive(arg_1_0._goPropItem, false)

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
	local var_4_0 = RoomProductionModel.instance:getLineMO(arg_4_0.viewParam.lineId)
	local var_4_1 = arg_4_0.viewParam.callback

	if var_4_1 then
		var_4_1(arg_4_0.viewParam.callbackObj)
	end

	RoomRpc.instance:sendStartProductionLineRequest(var_4_0.id, arg_4_0.viewParam.costItemAndFormulaIdList.formulaIdList, arg_4_0.costItemList)
	arg_4_0:closeThis()
end

function var_0_0._btnnoOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._rightImageRare = gohelper.findChildImage(arg_6_0.viewGO, "Exchange/Right/#image_rare")
	arg_6_0._sImageRightProduceItem = gohelper.findChildSingleImage(arg_6_0.viewGO, "Exchange/Right/#simage_produceitem")
	arg_6_0._txtRightNum = gohelper.findChildText(arg_6_0.viewGO, "Exchange/Right/image_NumBG/#txt_Num")
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)

	if not arg_7_0.viewParam then
		return
	end

	arg_7_0._contentGrid.enabled = false

	local var_7_0, var_7_1 = ItemModel.instance:getItemConfigAndIcon(arg_7_0.viewParam.produce.type, arg_7_0.viewParam.produce.id)

	arg_7_0._sImageRightProduceItem:LoadImage(var_7_1)
	UISpriteSetMgr.instance:setRoomSprite(arg_7_0._rightImageRare, "huangyuan_pz_" .. CharacterEnum.Color[var_7_0.rare])

	local var_7_2 = luaLang("multiple") .. tostring(arg_7_0.viewParam.produce.quantity)

	arg_7_0._txtRightNum.text = var_7_2

	local var_7_3 = string.format("%s%s", var_7_0.name, var_7_2)

	arg_7_0._txtdesc.text = formatLuaLang("room_formula_easy_combine_msg_box_tip", var_7_3)

	local var_7_4 = arg_7_0.viewParam.costItemAndFormulaIdList.itemTypeDic

	if var_7_4 then
		arg_7_0.costItemList = {}

		for iter_7_0, iter_7_1 in pairs(var_7_4) do
			for iter_7_2, iter_7_3 in pairs(iter_7_1) do
				if iter_7_3 > 0 then
					local var_7_5 = {
						type = iter_7_0,
						id = iter_7_2,
						quantity = iter_7_3
					}

					table.insert(arg_7_0.costItemList, var_7_5)
				end
			end
		end
	end

	RoomFormulaMsgBoxModel.instance:setCostItemList(arg_7_0.costItemList)

	if #RoomFormulaMsgBoxModel.instance:getList() <= arg_7_0.viewContainer.lineCount then
		transformhelper.setLocalPosXY(arg_7_0._goScrollView.transform, arg_7_0._originalScrollViewPosX, var_0_1)

		arg_7_0._contentGrid.enabled = true
	else
		arg_7_0._contentGrid.enabled = false

		transformhelper.setLocalPosXY(arg_7_0._goScrollView.transform, arg_7_0._originalScrollViewPosX, arg_7_0._originalScrollViewPosY)
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

return var_0_0
