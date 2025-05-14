module("modules.logic.battlepass.view.BpBonusSelectView", package.seeall)

local var_0_0 = class("BpBonusSelectView", BaseView)
local var_0_1 = {
	Finish = 3,
	CanGet = 2,
	Lock = 1
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "txt_titledec")
	arg_1_0._btnGet = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_get")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")
	arg_1_0._finish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._txtgetname = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_finish/#txt_getname")
	arg_1_0._items = {}

	for iter_1_0 = 1, 4 do
		local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "item" .. iter_1_0)

		arg_1_0._items[iter_1_0] = arg_1_0:getUserDataTb_()
		arg_1_0._items[iter_1_0].select = gohelper.findChild(var_1_0, "#go_select")
		arg_1_0._items[iter_1_0].btnClick = gohelper.findChildButtonWithAudio(var_1_0, "#btn_click")
		arg_1_0._items[iter_1_0].btnDetail = gohelper.findChildButtonWithAudio(var_1_0, "#btn_detail")
		arg_1_0._items[iter_1_0].imageSign = gohelper.findChildSingleImage(var_1_0, "#simage_sign")
		arg_1_0._items[iter_1_0].mask = gohelper.findChild(var_1_0, "#go_mask")
		arg_1_0._items[iter_1_0].owned = gohelper.findChild(var_1_0, "#go_owned")
		arg_1_0._items[iter_1_0].get = gohelper.findChild(var_1_0, "#go_get")
		arg_1_0._items[iter_1_0].getAnim = arg_1_0._items[iter_1_0].get:GetComponent(typeof(UnityEngine.Animator))

		if iter_1_0 == 4 then
			arg_1_0._items[iter_1_0].txtname = gohelper.findChildTextMesh(var_1_0, "#txt_name")
		else
			arg_1_0._items[iter_1_0].txtskinname = gohelper.findChildTextMesh(var_1_0, "#txt_skinname")
			arg_1_0._items[iter_1_0].txtname = gohelper.findChildTextMesh(var_1_0, "#txt_skinname/#txt_name")
		end

		arg_1_0:addClickCb(arg_1_0._items[iter_1_0].btnClick, arg_1_0._onGetClick, arg_1_0, iter_1_0)
		arg_1_0:addClickCb(arg_1_0._items[iter_1_0].btnDetail, arg_1_0._onDetailClick, arg_1_0, iter_1_0)
	end

	arg_1_0:addClickCb(arg_1_0._btnGet, arg_1_0._getBonus, arg_1_0)
	arg_1_0:addClickCb(arg_1_0._btnClose, arg_1_0.closeThis, arg_1_0)
end

function var_0_0.onClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

function var_0_0.onOpen(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2BPSP.play_ui_mln_unlock)

	local var_3_0 = BpConfig.instance:getBonusCOList(BpModel.instance.id)
	local var_3_1

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if not string.nilorempty(iter_3_1.selfSelectPayBonus) then
			var_3_1 = iter_3_1

			break
		end
	end

	if not var_3_1 then
		logError("没有皮肤可选！！！")

		return
	end

	arg_3_0._itemInfo = GameUtil.splitString2(var_3_1.selfSelectPayBonus, true)
	arg_3_0._level = var_3_1.level

	local var_3_2 = BpModel.instance:getBpLv()

	arg_3_0._getIndex = BpBonusModel.instance:isGetSelectBonus(arg_3_0._level)

	if BpModel.instance.firstShowSp or var_3_2 < arg_3_0._level then
		arg_3_0._statu = var_0_1.Lock

		arg_3_0:setFinish(0)
	elseif arg_3_0._getIndex then
		arg_3_0._statu = var_0_1.Finish

		arg_3_0:setFinish(arg_3_0._getIndex)
	else
		arg_3_0._statu = var_0_1.CanGet

		arg_3_0:setFinish(0)
	end

	arg_3_0:setSelect(0)
	gohelper.setActive(arg_3_0._btnGet, arg_3_0._statu == var_0_1.CanGet)
	gohelper.setActive(arg_3_0._golock, arg_3_0._statu == var_0_1.Lock)
	gohelper.setActive(arg_3_0._finish, arg_3_0._statu == var_0_1.Finish)
	gohelper.setActive(arg_3_0._goselect, arg_3_0._statu ~= var_0_1.Finish)
	ZProj.UGUIHelper.SetGrayFactor(arg_3_0._btnGet.gameObject, 1)

	for iter_3_2 = 1, 4 do
		local var_3_3 = ItemModel.instance:getItemQuantity(arg_3_0._itemInfo[iter_3_2][1], arg_3_0._itemInfo[iter_3_2][2]) > 0

		gohelper.setActive(arg_3_0._items[iter_3_2].owned, var_3_3)

		if arg_3_0._statu == var_0_1.Finish then
			gohelper.setActive(arg_3_0._items[iter_3_2].mask, arg_3_0._getIndex ~= iter_3_2)

			if arg_3_0._getIndex == iter_3_2 then
				gohelper.setActive(arg_3_0._items[iter_3_2].owned, false)
			end
		else
			gohelper.setActive(arg_3_0._items[iter_3_2].mask, var_3_3)
		end

		local var_3_4 = ItemConfig.instance:getItemConfig(arg_3_0._itemInfo[iter_3_2][1], arg_3_0._itemInfo[iter_3_2][2])
		local var_3_5 = ""

		if iter_3_2 == 4 then
			arg_3_0._items[iter_3_2].txtname.text = var_3_4.name
			var_3_5 = var_3_4.name
		else
			arg_3_0._items[iter_3_2].txtskinname.text = var_3_4.des

			local var_3_6 = HeroConfig.instance:getHeroCO(var_3_4.characterId)

			arg_3_0._items[iter_3_2].txtname.text = var_3_6.name
			var_3_5 = string.format("%s——%s", var_3_6.name, var_3_4.des)
		end

		if arg_3_0._getIndex == iter_3_2 then
			arg_3_0._txtgetname.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bp_sp_get_bound"), var_3_5)
		end
	end
end

function var_0_0.setSelect(arg_4_0, arg_4_1)
	for iter_4_0 = 1, 4 do
		gohelper.setActive(arg_4_0._items[iter_4_0].select, arg_4_1 == iter_4_0)
	end
end

function var_0_0.setFinish(arg_5_0, arg_5_1)
	for iter_5_0 = 1, 4 do
		gohelper.setActive(arg_5_0._items[iter_5_0].get, arg_5_1 == iter_5_0)

		if arg_5_1 == iter_5_0 then
			arg_5_0._items[iter_5_0].getAnim:Play("in")
		end
	end
end

function var_0_0._onGetClick(arg_6_0, arg_6_1)
	if arg_6_0._statu == var_0_1.CanGet then
		if arg_6_0._items[arg_6_1].mask.activeSelf then
			return
		end

		ZProj.UGUIHelper.SetGrayFactor(arg_6_0._btnGet.gameObject, 0)

		arg_6_0._nowSelect = arg_6_1

		arg_6_0:setSelect(arg_6_1)
	else
		arg_6_0:_onDetailClick(arg_6_1)
	end
end

function var_0_0._getBonus(arg_7_0)
	if not arg_7_0._nowSelect then
		return
	end

	BpRpc.instance:sendGetSelfSelectBonusRequest(arg_7_0._level or 0, arg_7_0._nowSelect - 1)
	arg_7_0:closeThis()
end

function var_0_0._onDetailClick(arg_8_0, arg_8_1)
	if not arg_8_0._itemInfo[arg_8_1] then
		return
	end

	MaterialTipController.instance:showMaterialInfo(arg_8_0._itemInfo[arg_8_1][1], arg_8_0._itemInfo[arg_8_1][2], false, nil, false)
end

return var_0_0
