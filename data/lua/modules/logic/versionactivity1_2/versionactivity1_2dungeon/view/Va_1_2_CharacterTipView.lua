module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.Va_1_2_CharacterTipView", package.seeall)

local var_0_0 = class("Va_1_2_CharacterTipView", CharacterTipView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goattributetip = gohelper.findChild(arg_1_0.viewGO, "#go_attributetip")
	arg_1_0._btnbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_attributetip/scrollview/viewport/#btn_bg")
	arg_1_0._goattributecontent = gohelper.findChild(arg_1_0.viewGO, "#go_attributetip/scrollview/viewport/content")
	arg_1_0._godetailcontent = gohelper.findChild(arg_1_0.viewGO, "#go_attributetip/#go_detailContent")
	arg_1_0._goattributecontentitem = gohelper.findChild(arg_1_0.viewGO, "#go_attributetip/#go_detailContent/detailscroll/Viewport/#go_attributeContent/#go_attributeItem")
	arg_1_0._gopassiveskilltip = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip")
	arg_1_0._goeffectdesc = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc")
	arg_1_0._goeffectdescitem = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc/#go_effectdescitem")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview")
	arg_1_0._gomask1 = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview/#go_mask1")
	arg_1_0._simageshadow = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview/#simage_shadow")
	arg_1_0._btnclosepassivetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_passiveskilltip/#btn_closepassivetip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbg:AddClickListener(arg_2_0._btnbgOnClick, arg_2_0)
	arg_2_0._scrollview:AddOnValueChanged(arg_2_0._onDragCallHandler, arg_2_0)
	arg_2_0._btnclosepassivetip:AddClickListener(arg_2_0._btnclosepassivetipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbg:RemoveClickListener()
	arg_3_0._scrollview:RemoveOnValueChanged()
	arg_3_0._btnclosepassivetip:RemoveClickListener()
end

function var_0_0.refreshBaseAttrItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:getBaseAttrValueList(arg_4_2)
	local var_4_1 = arg_4_0:getEquipAddBaseValues(arg_4_1, var_4_0)
	local var_4_2 = arg_4_0:getTalentValues(arg_4_2)
	local var_4_3 = VersionActivity1_2DungeonModel.instance:getAttrUpDic()

	for iter_4_0, iter_4_1 in ipairs(CharacterEnum.BaseAttrIdList) do
		local var_4_4 = gohelper.findChild(arg_4_0._attnormalitems[iter_4_0].value.gameObject, "img_up")

		gohelper.setActive(var_4_4, var_4_3[iter_4_1])

		local var_4_5 = HeroConfig.instance:getHeroAttributeCO(iter_4_1)
		local var_4_6 = var_4_1[iter_4_1] + (var_4_2[iter_4_1] and var_4_2[iter_4_1].value or 0) + (var_4_3[iter_4_1] or 0)

		arg_4_0._attnormalitems[iter_4_0].value.text = var_4_0[iter_4_1]
		arg_4_0._attnormalitems[iter_4_0].addValue.text = var_4_6 == 0 and "" or "+" .. var_4_6
		arg_4_0._attnormalitems[iter_4_0].name.text = var_4_5.name

		CharacterController.instance:SetAttriIcon(arg_4_0._attnormalitems[iter_4_0].icon, iter_4_1, GameUtil.parseColor("#323c34"))

		if var_4_5.isShowTips == 1 then
			local var_4_7 = {
				attributeId = var_4_5.id,
				icon = iter_4_1,
				go = arg_4_0._attnormalitems[iter_4_0].go
			}
			local var_4_8 = gohelper.getClick(arg_4_0._attnormalitems[iter_4_0].detail)

			var_4_8:AddClickListener(arg_4_0.showDetail, arg_4_0, var_4_7)
			table.insert(arg_4_0._detailClickItems, var_4_8)
			gohelper.setActive(arg_4_0._attnormalitems[iter_4_0].detail, true)
		else
			gohelper.setActive(arg_4_0._attnormalitems[iter_4_0].detail, false)
		end

		if arg_4_0._attnormalitems[iter_4_0].withDesc then
			local var_4_9, var_4_10 = arg_4_0:calculateTechnic(var_4_0[CharacterEnum.AttrId.Technic], arg_4_2)
			local var_4_11 = CommonConfig.instance:getConstStr(ConstEnum.CharacterTechnicDesc)
			local var_4_12 = {
				var_4_9,
				var_4_10
			}
			local var_4_13 = GameUtil.getSubPlaceholderLuaLang(var_4_11, var_4_12)

			arg_4_0._attnormalitems[iter_4_0].desc.text = var_4_13
		end
	end
end

function var_0_0.refreshUpAttrItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getBaseAttrValueList(arg_5_2)
	local var_5_1 = arg_5_0:_getTotalUpAttributes(arg_5_2)
	local var_5_2 = arg_5_0:getEquipBreakAddAttrValues(arg_5_1)
	local var_5_3 = arg_5_0:getTalentValues(arg_5_2)
	local var_5_4, var_5_5 = arg_5_0:calculateTechnic(var_5_0[CharacterEnum.AttrId.Technic], arg_5_2)
	local var_5_6 = VersionActivity1_2DungeonModel.instance:getAttrUpDic()

	for iter_5_0, iter_5_1 in ipairs(CharacterEnum.UpAttrIdList) do
		local var_5_7 = gohelper.findChild(arg_5_0._attrupperitems[iter_5_0].value.gameObject, "img_up")

		gohelper.setActive(var_5_7, var_5_6[iter_5_1])
		gohelper.setActive(arg_5_0._attrupperitems[iter_5_0].go, true)

		local var_5_8 = HeroConfig.instance:getHeroAttributeCO(iter_5_1)
		local var_5_9 = var_5_2[iter_5_1] + (var_5_3[iter_5_1] and var_5_3[iter_5_1].value or 0) + (var_5_6[iter_5_1] or 0) / 10
		local var_5_10 = (var_5_1[iter_5_1] or 0) / 10

		if iter_5_1 == CharacterEnum.AttrId.Cri then
			var_5_10 = var_5_10 + var_5_4
		end

		if iter_5_1 == CharacterEnum.AttrId.CriDmg then
			var_5_10 = var_5_10 + var_5_5
		end

		local var_5_11 = tostring(GameUtil.noMoreThanOneDecimalPlace(var_5_10)) .. "%"

		arg_5_0._attrupperitems[iter_5_0].value.text = var_5_11
		arg_5_0._attrupperitems[iter_5_0].addValue.text = var_5_9 == 0 and "" or "+" .. tostring(GameUtil.noMoreThanOneDecimalPlace(var_5_9)) .. "%"
		arg_5_0._attrupperitems[iter_5_0].name.text = var_5_8.name

		CharacterController.instance:SetAttriIcon(arg_5_0._attrupperitems[iter_5_0].icon, iter_5_1, CharacterTipView.AttrColor)

		if var_5_8.isShowTips == 1 then
			local var_5_12 = {
				attributeId = var_5_8.id,
				icon = iter_5_1,
				go = arg_5_0._attrupperitems[iter_5_0].go
			}
			local var_5_13 = gohelper.getClick(arg_5_0._attrupperitems[iter_5_0].detail)

			var_5_13:AddClickListener(arg_5_0.showDetail, arg_5_0, var_5_12)
			table.insert(arg_5_0._detailClickItems, var_5_13)
			gohelper.setActive(arg_5_0._attrupperitems[iter_5_0].detail, true)
		else
			gohelper.setActive(arg_5_0._attrupperitems[iter_5_0].detail, false)
		end
	end
end

return var_0_0
