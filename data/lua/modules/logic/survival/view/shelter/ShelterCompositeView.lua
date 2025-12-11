module("modules.logic.survival.view.shelter.ShelterCompositeView", package.seeall)

local var_0_0 = class("ShelterCompositeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goMaterial1 = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#go_material1")
	arg_1_0.goMaterial2 = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#go_material2")
	arg_1_0.materialItem1 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.goMaterial1, ShelterCompositeItem, {
		index = 1,
		compositeView = arg_1_0
	})
	arg_1_0.materialItem2 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.goMaterial2, ShelterCompositeItem, {
		index = 2,
		compositeView = arg_1_0
	})
	arg_1_0.goRightEmpty = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#go_material3/empty")
	arg_1_0.goRightHas = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#go_material3/has")
	arg_1_0.imageRightQuality = gohelper.findChildImage(arg_1_0.viewGO, "Panel/Right/#go_material3/has/#image_quality")
	arg_1_0.txtRightTips = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Right/#go_material3/has/tips/#txt_tips")
	arg_1_0.txtCount = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Right/#txt_count")
	arg_1_0.btnUncomposite = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Right/#btn_uncomposite")
	arg_1_0.btnComposite = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Right/#btn_composite")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnUncomposite, arg_2_0.onClickUncomposite, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnComposite, arg_2_0.onClickComposite, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnClickBagItem, arg_2_0.onClickBagItem, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_2_0.onShelterBagUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnUncomposite)
	arg_3_0:removeClickCb(arg_3_0.btnComposite)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnClickBagItem, arg_3_0.onClickBagItem, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_3_0.onShelterBagUpdate, arg_3_0)
end

function var_0_0.onShelterBagUpdate(arg_4_0)
	arg_4_0:refreshView()
end

function var_0_0.onEquipCompound(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 == 0 then
		local var_5_0 = arg_5_3.item
		local var_5_1 = SurvivalBagItemMo.New()

		var_5_1:init(var_5_0)

		var_5_1.source = SurvivalEnum.ItemSource.Shelter

		local var_5_2 = {
			itemMo = var_5_1
		}

		ViewMgr.instance:openView(ViewName.ShelterCompositeSuccessView, var_5_2)
	end
end

function var_0_0.onClickUncomposite(arg_6_0)
	arg_6_0:onClickComposite()
end

function var_0_0.onClickComposite(arg_7_0)
	local var_7_0 = arg_7_0:getSelectData(1)
	local var_7_1 = arg_7_0:getSelectData(2)

	if not (var_7_0 ~= nil and var_7_1 ~= nil) then
		GameFacade.showToast(ToastEnum.SurvivalCompositeSelectItem)

		return
	end

	local var_7_2 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.ShelterCompositeCost)
	local var_7_3, var_7_4, var_7_5, var_7_6 = arg_7_0:getBag():costIsEnough(var_7_2)

	if not var_7_3 then
		local var_7_7 = lua_survival_item.configDict[var_7_4]

		GameFacade.showToast(ToastEnum.DiamondBuy, var_7_7.name)

		return
	end

	local var_7_8 = {}

	table.insert(var_7_8, var_7_0.uid)
	table.insert(var_7_8, var_7_1.uid)
	SurvivalWeekRpc.instance:sendSurvivalEquipCompound(var_7_8, arg_7_0.onEquipCompound, arg_7_0)
end

function var_0_0.onClickBagItem(arg_8_0, arg_8_1)
	if not arg_8_0.selectIndex then
		return
	end

	arg_8_0.selectData[arg_8_0.selectIndex] = arg_8_1 and arg_8_1.uid or nil

	arg_8_0.viewContainer:closeMaterialView()
	arg_8_0:refreshView()
end

function var_0_0.showMaterialView(arg_9_0, arg_9_1)
	arg_9_0.selectIndex = arg_9_1

	arg_9_0.viewContainer:showMaterialView(arg_9_1)
end

function var_0_0.removeMaterialData(arg_10_0, arg_10_1)
	arg_10_0.selectData[arg_10_1] = nil

	arg_10_0:refreshView()
end

function var_0_0.isSelectItem(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_2 then
		return false
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0.selectData) do
		if iter_11_0 ~= arg_11_1 and iter_11_1 == arg_11_2.uid then
			return true
		end
	end
end

function var_0_0.onOpen(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_1)
	arg_12_0:refreshParam()
	arg_12_0:refreshView()
end

function var_0_0.refreshParam(arg_13_0)
	arg_13_0.selectData = {}
	arg_13_0.selectIndex = nil
end

function var_0_0.refreshView(arg_14_0)
	arg_14_0:refreshMaterialItem()
	arg_14_0:refreshRight()
end

function var_0_0.refreshMaterialItem(arg_15_0)
	arg_15_0.materialItem1:onUpdateMO(arg_15_0:getSelectData(1))
	arg_15_0.materialItem2:onUpdateMO(arg_15_0:getSelectData(2))
end

function var_0_0.refreshRight(arg_16_0)
	local var_16_0 = arg_16_0:getSelectData(1)
	local var_16_1 = arg_16_0:getSelectData(2)
	local var_16_2 = var_16_0 ~= nil and var_16_1 ~= nil

	gohelper.setActive(arg_16_0.goRightEmpty, not var_16_2)
	gohelper.setActive(arg_16_0.goRightHas, var_16_2)

	if var_16_2 then
		local var_16_3 = math.min(var_16_0.co.rare, var_16_1.co.rare)

		UISpriteSetMgr.instance:setSurvivalSprite(arg_16_0.imageRightQuality, string.format("survival_bag_itemquality%s", var_16_3))

		arg_16_0.txtRightTips.text = luaLang(string.format("survivalcompositeview_equip_tip%s", var_16_3))
	end

	local var_16_4 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.ShelterCompositeCost)
	local var_16_5, var_16_6, var_16_7, var_16_8 = arg_16_0:getBag():costIsEnough(var_16_4)

	if var_16_5 then
		arg_16_0.txtCount.text = string.format("%s/%s", var_16_8, var_16_7)
	else
		arg_16_0.txtCount.text = string.format("<color=#D74242>%s</color>/%s", var_16_8, var_16_7)
	end

	gohelper.setActive(arg_16_0.btnUncomposite, not var_16_2 or not var_16_5)
	gohelper.setActive(arg_16_0.btnComposite, var_16_2 and var_16_5)
end

function var_0_0.getBag(arg_17_0)
	return SurvivalMapHelper.instance:getBagMo()
end

function var_0_0.getSelectData(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.selectData[arg_18_1]

	if not var_18_0 then
		return
	end

	return (arg_18_0:getBag():getItemByUid(var_18_0))
end

function var_0_0.onClose(arg_19_0)
	return
end

return var_0_0
