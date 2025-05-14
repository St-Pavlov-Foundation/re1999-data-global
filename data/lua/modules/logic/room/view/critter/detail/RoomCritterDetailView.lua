module("modules.logic.room.view.critter.detail.RoomCritterDetailView", package.seeall)

local var_0_0 = class("RoomCritterDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._goyoung = gohelper.findChild(arg_1_0.viewGO, "#go_young")
	arg_1_0._gocritteritem = gohelper.findChild(arg_1_0.viewGO, "#go_young/#scroll_critter/viewport/content/#go_critteritem")
	arg_1_0._gocrittericon = gohelper.findChild(arg_1_0.viewGO, "#go_young/#scroll_critter/viewport/content/#go_critteritem/#go_crittericon")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "#go_young/Left/#go_detail")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_young/Left/#go_detail/#txt_name")
	arg_1_0._imagelock = gohelper.findChildImage(arg_1_0.viewGO, "#go_young/Left/#go_detail/#txt_name/#image_lock")
	arg_1_0._imagesort = gohelper.findChildImage(arg_1_0.viewGO, "#go_young/Left/#go_detail/#image_sort")
	arg_1_0._txtsort = gohelper.findChildText(arg_1_0.viewGO, "#go_young/Left/#go_detail/#image_sort/#txt_sort")
	arg_1_0._txttag1 = gohelper.findChildText(arg_1_0.viewGO, "#go_young/Left/#go_detail/tag/#txt_tag1")
	arg_1_0._txttag2 = gohelper.findChildText(arg_1_0.viewGO, "#go_young/Left/#go_detail/tag/#txt_tag2")
	arg_1_0._scrolldes = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_young/Left/#go_detail/#scroll_des")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_young/Left/#go_detail/#scroll_des/viewport/content/#txt_Desc")
	arg_1_0._scrollbase = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_young/Left/base/#scroll_base")
	arg_1_0._gobaseitem = gohelper.findChild(arg_1_0.viewGO, "#go_young/Left/base/#scroll_base/viewport/content/#go_baseitem")
	arg_1_0._scrolltipbase = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_young/Left/base/basetips/#scroll_base")
	arg_1_0._gobasetipsitem = gohelper.findChild(arg_1_0.viewGO, "#go_young/Left/base/basetips/#scroll_base/viewport/content/#go_basetipsitem")
	arg_1_0._scrollskill = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_young/Left/skill/#scroll_skill")
	arg_1_0._goskillItem = gohelper.findChild(arg_1_0.viewGO, "#go_young/Left/skill/#scroll_skill/viewport/content/#go_skillItem")
	arg_1_0._gocritterlive2d = gohelper.findChild(arg_1_0.viewGO, "#go_young/Right/#go_critterlive2d")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "#go_young/Left/#go_detail/starList")
	arg_1_0._gotipbase = gohelper.findChild(arg_1_0.viewGO, "#go_young/Left/base/basetips")
	arg_1_0._goLock = gohelper.findChild(arg_1_0.viewGO, "#go_young/Left/#go_detail/#txt_name/#image_lock")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0._lockbtn then
		arg_3_0._lockbtn:RemoveClickListener()
	end
end

function var_0_0._btnLockOnClick(arg_4_0)
	CritterRpc.instance:sendLockCritterRequest(arg_4_0._critterMo.uid, not arg_4_0._critterMo.lock, arg_4_0.refreshLock, arg_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	if arg_5_0._goLock then
		local var_5_0 = gohelper.findChild(arg_5_0._goLock, "clickarea")

		arg_5_0._lockbtn = SLFramework.UGUI.UIClickListener.Get(var_5_0)

		arg_5_0._lockbtn:AddClickListener(arg_5_0._btnLockOnClick, arg_5_0)
	end

	arg_5_0._starItem = arg_5_0:getUserDataTb_()

	if arg_5_0._gostar then
		for iter_5_0 = 1, arg_5_0._gostar.transform.childCount do
			arg_5_0._starItem[iter_5_0] = gohelper.findChild(arg_5_0._gostar, "star" .. iter_5_0)
		end
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._critterMo = arg_6_0.viewParam.critterMo

	if not arg_6_0._critterMo then
		return
	end

	gohelper.setActive(arg_6_0._gobaseitem.gameObject, false)
	gohelper.setActive(arg_6_0._goskillItem.gameObject, false)

	if arg_6_0._goLock then
		gohelper.setActive(arg_6_0._goLock.gameObject, not arg_6_0.viewParam.isPreview)
	end

	arg_6_0:onRefresh()
	arg_6_0:initAttrInfo()
end

function var_0_0.onRefresh(arg_7_0)
	if not arg_7_0._critterMo then
		return
	end

	arg_7_0:refreshLock()
	arg_7_0:showInfo()
	arg_7_0:refrshCritterSpine()
	arg_7_0:refreshAttrInfo()
end

function var_0_0.onClickModalMask(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0.showInfo(arg_9_0)
	if not arg_9_0._critterMo then
		return
	end

	arg_9_0._txtname.text = arg_9_0._critterMo:getName()
	arg_9_0._txtsort.text = arg_9_0._critterMo:getCatalogueName()
	arg_9_0._txtDesc.text = arg_9_0._critterMo:getDesc()

	local var_9_0 = arg_9_0._critterMo:isMaturity() and "room_critter_adult" or "room_critter_child"

	arg_9_0._txttag1.text = luaLang(var_9_0)

	local var_9_1 = arg_9_0._critterMo:isMutate()

	gohelper.setActive(arg_9_0._txttag2.gameObject, var_9_1)

	local var_9_2 = arg_9_0._critterMo:getDefineCfg().rare

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._starItem) do
		gohelper.setActive(iter_9_1, iter_9_0 <= var_9_2 + 1)
	end

	arg_9_0:showAttr()
	arg_9_0:showSkill()
end

function var_0_0.showAttr(arg_10_0)
	local var_10_0 = arg_10_0._critterMo:getAttributeInfos()

	if not arg_10_0._attrItems then
		arg_10_0._attrItems = arg_10_0:getUserDataTb_()
	end

	local var_10_1 = 1

	if var_10_0 then
		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			local var_10_2 = arg_10_0:getAttrItem(var_10_1)
			local var_10_3, var_10_4 = arg_10_0:getAttrRatioColor()

			var_10_2:setRatioColor(var_10_3, var_10_4)
			var_10_2:onRefreshMo(iter_10_1, var_10_1, arg_10_0:getAttrNum(iter_10_0, iter_10_1), arg_10_0:getAttrRatio(iter_10_0, iter_10_1), arg_10_0:getAttrName(iter_10_0, iter_10_1), arg_10_0.attrOnClick, arg_10_0)

			var_10_1 = var_10_1 + 1
		end
	end

	for iter_10_2 = 1, #arg_10_0._attrItems do
		gohelper.setActive(arg_10_0._attrItems[iter_10_2].viewGO, iter_10_2 < var_10_1)
	end
end

function var_0_0.getAttrNum(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_2:getValueNum()
end

function var_0_0.getAttrRatio(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_2:getRateStr()
end

function var_0_0.getAttrName(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_2:getName()
end

function var_0_0.getAttrItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._attrItems[arg_14_1]

	if not var_14_0 then
		local var_14_1 = gohelper.cloneInPlace(arg_14_0._gobaseitem)

		var_14_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_1, RoomCritterDetailAttrItem)
		arg_14_0._attrItems[arg_14_1] = var_14_0
	end

	return var_14_0
end

function var_0_0.showSkill(arg_15_0)
	local var_15_0 = arg_15_0._critterMo:getSkillInfo()

	if not arg_15_0._skillItems then
		arg_15_0._skillItems = arg_15_0:getUserDataTb_()
	end

	local var_15_1 = 1

	if var_15_0 then
		for iter_15_0, iter_15_1 in pairs(var_15_0) do
			local var_15_2 = CritterConfig.instance:getCritterTagCfg(iter_15_1)

			if var_15_2 and var_15_2.type == var_0_0._exclusiveSkill then
				arg_15_0:getSkillItem(var_15_1):onRefreshMo(var_15_2, var_15_1)

				var_15_1 = var_15_1 + 1
			end
		end
	end

	if arg_15_0._skillItems then
		for iter_15_2 = 1, #arg_15_0._skillItems do
			gohelper.setActive(arg_15_0._skillItems[iter_15_2].viewGO, iter_15_2 < var_15_1)
		end
	end
end

function var_0_0.getSkillItem(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._skillItems[arg_16_1]

	if not var_16_0 then
		local var_16_1 = gohelper.cloneInPlace(arg_16_0._goskillItem)

		var_16_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_1, RoomCritterDetailSkillItem)
		arg_16_0._skillItems[arg_16_1] = var_16_0
	end

	return var_16_0
end

function var_0_0.refreshLock(arg_17_0)
	if not arg_17_0.viewParam.isPreview then
		local var_17_0 = arg_17_0._critterMo:isLock() and "xinxiang_suo" or "xinxiang_jiesuo"

		UISpriteSetMgr.instance:setEquipSprite(arg_17_0._imagelock, var_17_0, false)
	end
end

function var_0_0.getAttrRatioColor(arg_18_0)
	return "#CAC8C5", "#FFAE46"
end

function var_0_0.initAttrInfo(arg_19_0)
	gohelper.setActive(arg_19_0._gotipbase.gameObject, false)
	arg_19_0:refreshAttrInfo()
end

function var_0_0.refreshAttrInfo(arg_20_0)
	local var_20_0 = arg_20_0._critterMo:getAttributeInfos()

	if not arg_20_0._tipAttrItems then
		arg_20_0._tipAttrItems = arg_20_0:getUserDataTb_()
	end

	local var_20_1 = 1

	if var_20_0 then
		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			if iter_20_1:getIsAddition() then
				local var_20_2 = arg_20_0:getTipAttrItem(var_20_1)

				if var_20_2 then
					arg_20_0:setAttrTipText(var_20_2, iter_20_1)

					if var_20_2.icon and not string.nilorempty(iter_20_1:getIcon()) then
						UISpriteSetMgr.instance:setCritterSprite(var_20_2.icon, iter_20_1:getIcon())
					end
				end

				var_20_1 = var_20_1 + 1
			end
		end
	end

	for iter_20_2 = 1, #arg_20_0._tipAttrItems do
		gohelper.setActive(arg_20_0._tipAttrItems[iter_20_2].go, iter_20_2 < var_20_1)
	end
end

function var_0_0.setAttrTipText(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1.nametxt then
		arg_21_1.nametxt.text = arg_21_2:getName()
	end

	if arg_21_1.uptxt then
		arg_21_1.uptxt.text = arg_21_2:getaddRateStr()
	end

	if arg_21_1.numtxt then
		arg_21_1.numtxt.text = arg_21_2:getValueNum()
	end

	if arg_21_1.ratiotxt then
		arg_21_1.ratiotxt.text = arg_21_2:getRateStr()
	end
end

function var_0_0.attrOnClick(arg_22_0)
	gohelper.setActive(arg_22_0._gotipbase.gameObject, true)
end

function var_0_0.getTipAttrItem(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._tipAttrItems[arg_23_1]

	if not var_23_0 then
		var_23_0 = {}

		local var_23_1 = gohelper.cloneInPlace(arg_23_0._gobasetipsitem)

		var_23_0.nametxt = gohelper.findChildText(var_23_1, "#txt_name")
		var_23_0.uptxt = gohelper.findChildText(var_23_1, "#txt_up")
		var_23_0.icon = gohelper.findChildImage(var_23_1, "#txt_name/#image_icon")
		var_23_0.ratiotxt = gohelper.findChildText(var_23_1, "#txt_ratio")
		var_23_0.numtxt = gohelper.findChildText(var_23_1, "#txt_num")
		var_23_0.go = var_23_1
		arg_23_0._tipAttrItems[arg_23_1] = var_23_0
	end

	return var_23_0
end

function var_0_0.refrshCritterSpine(arg_24_0)
	if not arg_24_0.bigSpine then
		arg_24_0.bigSpine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_24_0._gocritterlive2d, RoomCritterUISpine)
	end

	arg_24_0.bigSpine:setResPath(arg_24_0._critterMo)
end

function var_0_0.onClose(arg_25_0)
	return
end

function var_0_0.onDestroyView(arg_26_0)
	return
end

var_0_0._exclusiveSkill = CritterEnum.SkilTagType.Race

return var_0_0
