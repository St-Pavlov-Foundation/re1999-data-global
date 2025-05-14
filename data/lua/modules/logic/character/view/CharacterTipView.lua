module("modules.logic.character.view.CharacterTipView", package.seeall)

local var_0_0 = class("CharacterTipView", BaseView)

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
	arg_1_0._goBuffContainer = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer")
	arg_1_0._btnclosebuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buffContainer/buff_bg")
	arg_1_0._goBuffItem = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem")
	arg_1_0._txtBuffName = gohelper.findChildText(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name")
	arg_1_0._goBuffTag = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag")
	arg_1_0._txtBuffTagName = gohelper.findChildText(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	arg_1_0._txtBuffDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem/txt_desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbg:AddClickListener(arg_2_0._btnbgOnClick, arg_2_0)
	arg_2_0._btnclosebuff:AddClickListener(arg_2_0._btnclosebuffOnClick, arg_2_0)
	arg_2_0._scrollview:AddOnValueChanged(arg_2_0._onDragCallHandler, arg_2_0)
	arg_2_0._btnclosepassivetip:AddClickListener(arg_2_0._btnclosepassivetipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbg:RemoveClickListener()
	arg_3_0._btnclosebuff:RemoveClickListener()
	arg_3_0._scrollview:RemoveOnValueChanged()
	arg_3_0._btnclosepassivetip:RemoveClickListener()
end

var_0_0.DetailOffset = 25
var_0_0.DetailBottomPos = -133.7
var_0_0.DetailClickMinPos = -148
var_0_0.AttrColor = GameUtil.parseColor("#323c34")

function var_0_0._btnbgOnClick(arg_4_0)
	if not arg_4_0._isOpenAttrDesc then
		return
	end

	arg_4_0._isOpenAttrDesc = false

	gohelper.setActive(arg_4_0._godetailcontent, false)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_role_description)
end

function var_0_0._btnclosebuffOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._goBuffContainer, false)
end

function var_0_0._btnclosepassivetipOnClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_6_0:closeThis()
end

function var_0_0._onDragCallHandler(arg_7_0)
	gohelper.setActive(arg_7_0._gomask1, arg_7_0._couldScroll and not (gohelper.getRemindFourNumberFloat(arg_7_0._scrollview.verticalNormalizedPosition) <= 0))

	arg_7_0._passiveskilltipmask.enabled = arg_7_0._couldScroll and gohelper.getRemindFourNumberFloat(arg_7_0._scrollview.verticalNormalizedPosition) < 1
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._isOpenAttrDesc = false

	gohelper.setActive(arg_8_0._goBuffContainer, false)

	arg_8_0.gocontent = gohelper.findChild(arg_8_0._goattributetip, "scrollview/viewport/content")
	arg_8_0.gotitleitem = gohelper.findChild(arg_8_0._goattributetip, "scrollview/viewport/content/titleitem")
	arg_8_0.godescitem = gohelper.findChild(arg_8_0._goattributetip, "scrollview/viewport/content/descitem")
	arg_8_0.goattrnormalitem = gohelper.findChild(arg_8_0._goattributetip, "scrollview/viewport/content/attrnormalitem")
	arg_8_0.goattrnormalwithdescitem = gohelper.findChild(arg_8_0._goattributetip, "scrollview/viewport/content/attrnormalwithdescitem")
	arg_8_0.goattrupperitem = gohelper.findChild(arg_8_0._goattributetip, "scrollview/viewport/content/attrupperitem")
	arg_8_0._txtDetailItemName = gohelper.findChildText(arg_8_0._goattributecontentitem, "name")
	arg_8_0._txtDetailItemIcon = gohelper.findChildImage(arg_8_0._goattributecontentitem, "name/icon")
	arg_8_0._txtDetailItemDesc = gohelper.findChildText(arg_8_0._goattributecontentitem, "desc")
	arg_8_0._passiveskilltipcontent = gohelper.findChild(arg_8_0._gopassiveskilltip, "mask/root/scrollview/viewport/content")
	arg_8_0._passiveskilltipmask = gohelper.findChild(arg_8_0._gopassiveskilltip, "mask"):GetComponent(typeof(UnityEngine.UI.RectMask2D))

	gohelper.setActive(arg_8_0.gotitleitem, false)
	gohelper.setActive(arg_8_0.godescitem, false)
	gohelper.setActive(arg_8_0.goattrnormalitem, false)
	gohelper.setActive(arg_8_0.goattrnormalwithdescitem, false)
	gohelper.setActive(arg_8_0.goattrupperitem, false)

	arg_8_0.goTotalTitle = gohelper.clone(arg_8_0.gotitleitem, arg_8_0.gocontent, "totaltitle")

	gohelper.setActive(arg_8_0.goTotalTitle, false)
	arg_8_0:_setTitleText(arg_8_0.goTotalTitle, luaLang("character_tip_total_attribute"), "STATS")

	arg_8_0.goDescTitle = gohelper.clone(arg_8_0.godescitem, arg_8_0.gocontent, "descitem")

	gohelper.setActive(arg_8_0.goDescTitle, false)

	arg_8_0._attnormalitems = {}

	for iter_8_0 = 1, 4 do
		local var_8_0 = arg_8_0:getUserDataTb_()

		var_8_0.go = gohelper.clone(arg_8_0.goattrnormalitem, arg_8_0.gocontent, "attrnormal" .. 1)

		gohelper.setActive(var_8_0.go, true)

		var_8_0.value = gohelper.findChildText(var_8_0.go, "value")
		var_8_0.addValue = gohelper.findChildText(var_8_0.go, "addvalue")
		var_8_0.name = gohelper.findChildText(var_8_0.go, "name")
		var_8_0.icon = gohelper.findChildImage(var_8_0.go, "icon")
		var_8_0.rate = gohelper.findChildImage(var_8_0.go, "rate")
		var_8_0.detail = gohelper.findChild(var_8_0.go, "btndetail")
		var_8_0.withDesc = false
		arg_8_0._attnormalitems[iter_8_0] = var_8_0
	end

	local var_8_1 = arg_8_0:getUserDataTb_()

	var_8_1.go = gohelper.clone(arg_8_0.goattrnormalwithdescitem, arg_8_0.gocontent, "attrnormal" .. #arg_8_0._attnormalitems + 1)

	gohelper.setActive(var_8_1.go, true)

	var_8_1.value = gohelper.findChildText(var_8_1.go, "attr/value")
	var_8_1.addValue = gohelper.findChildText(var_8_1.go, "attr/addvalue")
	var_8_1.name = gohelper.findChildText(var_8_1.go, "attr/namelayout/name")
	var_8_1.icon = gohelper.findChildImage(var_8_1.go, "attr/icon")
	var_8_1.detail = gohelper.findChild(var_8_1.go, "attr/btndetail")
	var_8_1.desc = gohelper.findChildText(var_8_1.go, "desc/#txt_desc")
	var_8_1.withDesc = true
	arg_8_0._attnormalitems[#arg_8_0._attnormalitems + 1] = var_8_1
	arg_8_0._attrupperitems = {}

	for iter_8_1 = 1, 12 do
		arg_8_0:_getAttrUpperItem(iter_8_1)
	end

	arg_8_0._passiveskillitems = {}

	for iter_8_2 = 1, 3 do
		local var_8_2 = arg_8_0:getUserDataTb_()

		var_8_2.go = gohelper.findChild(arg_8_0._gopassiveskilltip, "mask/root/scrollview/viewport/content/talentstar" .. tostring(iter_8_2))
		var_8_2.desc = gohelper.findChildTextMesh(var_8_2.go, "desctxt")
		var_8_2.hyperLinkClick = SkillHelper.addHyperLinkClick(var_8_2.desc, arg_8_0._onHyperLinkClick, arg_8_0)
		var_8_2.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_2.desc.gameObject, FixTmpBreakLine)
		var_8_2.on = gohelper.findChild(var_8_2.go, "#go_passiveskills/passiveskill/on")
		var_8_2.unlocktxt = gohelper.findChildText(var_8_2.go, "#go_passiveskills/passiveskill/unlocktxt")
		var_8_2.canvasgroup = gohelper.onceAddComponent(var_8_2.go, typeof(UnityEngine.CanvasGroup))
		var_8_2.connectline = gohelper.findChild(var_8_2.go, "line")
		arg_8_0._passiveskillitems[iter_8_2] = var_8_2
	end

	arg_8_0._txtpassivename = gohelper.findChildText(arg_8_0.viewGO, "#go_passiveskilltip/name/bg/#txt_passivename")
	arg_8_0._detailClickItems = {}
	arg_8_0._detailDescTab = arg_8_0:getUserDataTb_()
	arg_8_0._skillEffectDescItems = arg_8_0:getUserDataTb_()

	arg_8_0._simageshadow:LoadImage(ResUrl.getCharacterIcon("bg_shade"))
end

function var_0_0._getAttrUpperItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._attrupperitems[arg_9_1]

	if not var_9_0 then
		var_9_0 = arg_9_0:getUserDataTb_()
		var_9_0.go = gohelper.clone(arg_9_0.goattrupperitem, arg_9_0.gocontent, "attrupper" .. arg_9_1)

		gohelper.setActive(var_9_0.go, true)

		var_9_0.value = gohelper.findChildText(var_9_0.go, "value")
		var_9_0.addValue = gohelper.findChildText(var_9_0.go, "addvalue")
		var_9_0.name = gohelper.findChildText(var_9_0.go, "name")
		var_9_0.icon = gohelper.findChildImage(var_9_0.go, "icon")
		var_9_0.detail = gohelper.findChild(var_9_0.go, "btndetail")
		arg_9_0._attrupperitems[arg_9_1] = var_9_0
	end

	return var_9_0
end

function var_0_0._setTitleText(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = gohelper.findChildText(arg_10_1, "attcn")

	if var_10_0 then
		var_10_0.text = arg_10_2
	end

	local var_10_1 = gohelper.findChildText(arg_10_1, "atten")

	if var_10_1 then
		var_10_1.text = arg_10_3
	end
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageshadow:UnLoadImage()
end

function var_0_0.onOpen(arg_13_0)
	gohelper.setActive(arg_13_0._godetailcontent, false)

	local var_13_0 = arg_13_0.viewParam

	arg_13_0.heroId = arg_13_0.viewParam.heroid
	arg_13_0._level = arg_13_0.viewParam.level
	arg_13_0._rank = arg_13_0.viewParam.rank
	arg_13_0._passiveSkillLevel = arg_13_0.viewParam.passiveSkillLevel
	arg_13_0._setEquipInfo = arg_13_0.viewParam.setEquipInfo
	arg_13_0._talentCubeInfos = arg_13_0.viewParam.talentCubeInfos
	arg_13_0._balanceHelper = arg_13_0.viewParam.balanceHelper or HeroGroupBalanceHelper

	gohelper.setActive(arg_13_0.goDescTitle, true)
	gohelper.setActive(arg_13_0.goTotalTitle, true)
	gohelper.setActive(arg_13_0._goattributetip, var_13_0.tag == "attribute")
	gohelper.setActive(arg_13_0._gopassiveskilltip, var_13_0.tag == "passiveskill")

	var_13_0.showAttributeOption = var_13_0.showAttributeOption or CharacterEnum.showAttributeOption.ShowCurrent

	if var_13_0.tag == "attribute" then
		arg_13_0:_setAttribute(var_13_0.equips, var_13_0.showAttributeOption)
	elseif var_13_0.tag == "passiveskill" then
		arg_13_0:_setPassiveSkill(var_13_0.heroid, var_13_0.showAttributeOption, var_13_0.anchorParams, var_13_0.tipPos)
	end
end

function var_0_0._setAttribute(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0 = 7, 11 do
		gohelper.setActive(arg_14_0._attrupperitems[iter_14_0].go, false)
	end

	arg_14_0:refreshBaseAttrItem(arg_14_1, arg_14_2)
	arg_14_0:refreshUpAttrItem(arg_14_1, arg_14_2)
end

function var_0_0.refreshBaseAttrItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getBaseAttrValueList(arg_15_2)
	local var_15_1 = arg_15_0:getEquipAddBaseValues(arg_15_1, var_15_0)
	local var_15_2 = arg_15_0:getTalentValues(arg_15_2)
	local var_15_3 = arg_15_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_15_0.heroId)
	local var_15_4 = var_15_3 and var_15_3.destinyStoneMo
	local var_15_5 = var_15_4 and var_15_4:getAddAttrValues()

	for iter_15_0, iter_15_1 in ipairs(CharacterEnum.BaseAttrIdList) do
		local var_15_6 = HeroConfig.instance:getHeroAttributeCO(iter_15_1)
		local var_15_7 = var_15_4 and var_15_4:getAddValueByAttrId(var_15_5, iter_15_1) or 0
		local var_15_8 = var_15_1[iter_15_1] + (var_15_2[iter_15_1] and var_15_2[iter_15_1].value or 0) + var_15_7

		arg_15_0._attnormalitems[iter_15_0].value.text = var_15_0[iter_15_1]
		arg_15_0._attnormalitems[iter_15_0].addValue.text = var_15_8 == 0 and "" or "+" .. var_15_8
		arg_15_0._attnormalitems[iter_15_0].name.text = var_15_6.name

		CharacterController.instance:SetAttriIcon(arg_15_0._attnormalitems[iter_15_0].icon, iter_15_1, GameUtil.parseColor("#323c34"))

		if var_15_6.isShowTips == 1 then
			local var_15_9 = {
				attributeId = var_15_6.id,
				icon = iter_15_1,
				go = arg_15_0._attnormalitems[iter_15_0].go
			}
			local var_15_10 = gohelper.getClick(arg_15_0._attnormalitems[iter_15_0].detail)

			var_15_10:AddClickListener(arg_15_0.showDetail, arg_15_0, var_15_9)
			table.insert(arg_15_0._detailClickItems, var_15_10)
			gohelper.setActive(arg_15_0._attnormalitems[iter_15_0].detail, true)
		else
			gohelper.setActive(arg_15_0._attnormalitems[iter_15_0].detail, false)
		end

		if arg_15_0._attnormalitems[iter_15_0].withDesc then
			local var_15_11, var_15_12 = arg_15_0:calculateTechnic(var_15_0[CharacterEnum.AttrId.Technic], arg_15_2)
			local var_15_13 = CommonConfig.instance:getConstStr(ConstEnum.CharacterTechnicDesc)
			local var_15_14 = string.gsub(var_15_13, "▩1%%s", var_15_11)
			local var_15_15 = string.gsub(var_15_14, "▩2%%s", var_15_12)

			arg_15_0._attnormalitems[iter_15_0].desc.text = var_15_15
		end
	end
end

function var_0_0.refreshUpAttrItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getBaseAttrValueList(arg_16_2)
	local var_16_1 = arg_16_0:_getTotalUpAttributes(arg_16_2)
	local var_16_2 = arg_16_0:getEquipBreakAddAttrValues(arg_16_1)
	local var_16_3 = arg_16_0:getTalentValues(arg_16_2)
	local var_16_4 = arg_16_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_16_0.heroId)
	local var_16_5 = var_16_4 and var_16_4.destinyStoneMo
	local var_16_6 = var_16_5 and var_16_5:getAddAttrValues()
	local var_16_7, var_16_8 = arg_16_0:calculateTechnic(var_16_0[CharacterEnum.AttrId.Technic], arg_16_2)
	local var_16_9 = 1

	for iter_16_0, iter_16_1 in ipairs(CharacterEnum.UpAttrIdList) do
		gohelper.setActive(arg_16_0._attrupperitems[iter_16_0].go, true)

		local var_16_10 = HeroConfig.instance:getHeroAttributeCO(iter_16_1)
		local var_16_11 = var_16_5 and var_16_5:getAddValueByAttrId(var_16_6, iter_16_1) or 0
		local var_16_12 = var_16_2[iter_16_1] + (var_16_3[iter_16_1] and var_16_3[iter_16_1].value or 0) + var_16_11
		local var_16_13 = (var_16_1[iter_16_1] or 0) / 10

		if iter_16_1 == CharacterEnum.AttrId.Cri then
			var_16_13 = var_16_13 + var_16_7
		end

		if iter_16_1 == CharacterEnum.AttrId.CriDmg then
			var_16_13 = var_16_13 + var_16_8
		end

		local var_16_14 = tostring(GameUtil.noMoreThanOneDecimalPlace(var_16_13)) .. "%"

		arg_16_0._attrupperitems[iter_16_0].value.text = var_16_14
		arg_16_0._attrupperitems[iter_16_0].addValue.text = var_16_12 == 0 and "" or "+" .. tostring(GameUtil.noMoreThanOneDecimalPlace(var_16_12)) .. "%"
		arg_16_0._attrupperitems[iter_16_0].name.text = var_16_10.name

		CharacterController.instance:SetAttriIcon(arg_16_0._attrupperitems[iter_16_0].icon, iter_16_1, var_0_0.AttrColor)

		if var_16_10.isShowTips == 1 then
			local var_16_15 = {
				attributeId = var_16_10.id,
				icon = iter_16_1,
				go = arg_16_0._attrupperitems[iter_16_0].go
			}
			local var_16_16 = gohelper.getClick(arg_16_0._attrupperitems[iter_16_0].detail)

			var_16_16:AddClickListener(arg_16_0.showDetail, arg_16_0, var_16_15)
			table.insert(arg_16_0._detailClickItems, var_16_16)
			gohelper.setActive(arg_16_0._attrupperitems[iter_16_0].detail, true)
		else
			gohelper.setActive(arg_16_0._attrupperitems[iter_16_0].detail, false)
		end

		var_16_9 = var_16_9 + 1
	end

	for iter_16_2, iter_16_3 in ipairs(CharacterDestinyEnum.DestinyUpSpecialAttr) do
		local var_16_17 = var_16_5 and var_16_5:getAddValueByAttrId(var_16_6, iter_16_3) or 0

		if var_16_17 ~= 0 then
			local var_16_18 = arg_16_0:_getAttrUpperItem(var_16_9)

			gohelper.setActive(var_16_18.go, true)

			local var_16_19 = HeroConfig.instance:getHeroAttributeCO(iter_16_3)

			var_16_18.value.text = 0

			local var_16_20 = "+" .. tostring(GameUtil.noMoreThanOneDecimalPlace(var_16_17)) .. "%"

			var_16_18.addValue.text = var_16_17 == 0 and "" or var_16_20
			var_16_18.name.text = var_16_19.name

			CharacterController.instance:SetAttriIcon(var_16_18.icon, iter_16_3, var_0_0.AttrColor)

			if var_16_19.isShowTips == 1 then
				local var_16_21 = {
					attributeId = var_16_19.id,
					icon = iter_16_3,
					go = var_16_18.go
				}
				local var_16_22 = gohelper.getClick(var_16_18.detail)

				var_16_22:AddClickListener(arg_16_0.showDetail, arg_16_0, var_16_21)
				table.insert(arg_16_0._detailClickItems, var_16_22)
				gohelper.setActive(var_16_18.detail, true)
			else
				gohelper.setActive(var_16_18.detail, false)
			end

			var_16_9 = var_16_9 + 1
		end
	end
end

function var_0_0.getBaseAttrValueList(arg_17_0, arg_17_1)
	local var_17_0 = {}

	if arg_17_1 == CharacterEnum.showAttributeOption.ShowMax then
		var_17_0 = arg_17_0:_getMaxNormalAtrributes()
	elseif arg_17_1 == CharacterEnum.showAttributeOption.ShowMin then
		var_17_0 = arg_17_0:_getMinNormalAttribute()
	else
		local var_17_1 = arg_17_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_17_0.heroId)
		local var_17_2 = arg_17_0._level
		local var_17_3 = arg_17_0._rank

		if arg_17_0.viewParam.isBalance then
			var_17_2 = arg_17_0._balanceHelper.getHeroBalanceLv(var_17_1.heroId)
			_, var_17_3 = HeroConfig.instance:getShowLevel(var_17_2)
		end

		var_17_0 = var_17_1:getHeroBaseAttrDict(var_17_2, var_17_3)
	end

	return var_17_0
end

function var_0_0.getEquipAddBaseValues(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(CharacterEnum.BaseAttrIdList) do
		var_18_0[iter_18_1] = 0
		var_18_1[iter_18_1] = 0
	end

	local var_18_2

	if arg_18_0.viewParam.isBalance then
		_, _, var_18_2 = arg_18_0._balanceHelper.getBalanceLv()
	end

	local var_18_3 = arg_18_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_18_0.heroId)

	if arg_18_1 then
		if arg_18_0.viewParam.trialEquipMo then
			var_18_3:_calcEquipAttr(arg_18_0.viewParam.trialEquipMo, var_18_0, var_18_1)
		end

		for iter_18_2 = 1, #arg_18_1 do
			local var_18_4 = EquipModel.instance:getEquip(arg_18_1[iter_18_2])

			var_18_4 = var_18_4 and arg_18_0:_modifyEquipInfo(var_18_4)

			var_18_3:_calcEquipAttr(var_18_4, var_18_0, var_18_1, var_18_2)
		end
	end

	for iter_18_3, iter_18_4 in ipairs(CharacterEnum.BaseAttrIdList) do
		var_18_0[iter_18_4] = var_18_0[iter_18_4] + math.floor(var_18_1[iter_18_4] / 1000 * arg_18_2[iter_18_4])
	end

	return var_18_0
end

function var_0_0._modifyEquipInfo(arg_19_0, arg_19_1)
	if arg_19_0._setEquipInfo then
		local var_19_0 = arg_19_0._setEquipInfo[1]
		local var_19_1 = arg_19_0._setEquipInfo[2]
		local var_19_2 = arg_19_0._setEquipInfo[3]

		if var_19_2 and var_19_2.isCachot then
			return var_19_0(var_19_1, {
				seatLevel = var_19_2.seatLevel,
				equipMO = arg_19_1
			})
		end
	end

	return arg_19_1
end

function var_0_0.getTalentValues(arg_20_0, arg_20_1)
	local var_20_0 = {}

	if arg_20_1 == CharacterEnum.showAttributeOption.ShowCurrent then
		local var_20_1 = arg_20_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_20_0.heroId)

		if arg_20_0.viewParam.isBalance then
			local var_20_2, var_20_3, var_20_4, var_20_5 = arg_20_0._balanceHelper.getHeroBalanceInfo(var_20_1.heroId)

			var_20_0 = var_20_1:getTalentGain(var_20_2, var_20_3, nil, var_20_5)
		else
			var_20_0 = var_20_1:getTalentGain(arg_20_0._level or var_20_1.level, arg_20_0._rank, nil, arg_20_0._talentCubeInfos)
		end

		var_20_0 = HeroConfig.instance:talentGainTab2IDTab(var_20_0)

		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			if HeroConfig.instance:getHeroAttributeCO(iter_20_0).type ~= 1 then
				var_20_0[iter_20_0].value = var_20_0[iter_20_0].value / 10
			else
				var_20_0[iter_20_0].value = math.floor(var_20_0[iter_20_0].value)
			end
		end
	end

	return var_20_0
end

function var_0_0.getDestinyStoneAddValues(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_21_0.heroId)

	if var_21_0 then
		local var_21_1 = var_21_0.destinyStoneMo

		if var_21_1 then
			return var_21_1:getAddAttrValues()
		end
	end
end

function var_0_0.getEquipBreakAddAttrValues(arg_22_0, arg_22_1)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(CharacterEnum.BaseAttrIdList) do
		var_22_0[iter_22_1] = 0
	end

	for iter_22_2, iter_22_3 in ipairs(CharacterEnum.UpAttrIdList) do
		var_22_0[iter_22_3] = 0
	end

	if arg_22_1 and arg_22_0.viewParam.heroMo and arg_22_0.viewParam.trialEquipMo then
		local var_22_1 = arg_22_0.viewParam.trialEquipMo
		local var_22_2, var_22_3 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(var_22_1.config, var_22_1.breakLv)

		if var_22_2 then
			var_22_0[var_22_2] = var_22_0[var_22_2] + var_22_3
		end
	end

	if arg_22_1 and #arg_22_1 > 0 then
		for iter_22_4, iter_22_5 in ipairs(arg_22_1) do
			local var_22_4 = EquipModel.instance:getEquip(iter_22_5)

			if var_22_4 then
				local var_22_5 = arg_22_0:_modifyEquipInfo(var_22_4)
				local var_22_6, var_22_7 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(var_22_5.config, var_22_5.breakLv)

				if var_22_6 then
					var_22_0[var_22_6] = var_22_0[var_22_6] + var_22_7
				end
			end
		end
	end

	for iter_22_6, iter_22_7 in pairs(var_22_0) do
		var_22_0[iter_22_6] = iter_22_7 / 10
	end

	return var_22_0
end

function var_0_0.calculateTechnic(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0
	local var_23_1
	local var_23_2

	if arg_23_2 == CharacterEnum.showAttributeOption.ShowMax then
		var_23_2 = CharacterModel.instance:getMaxLevel(arg_23_0.viewParam.heroid)
	elseif arg_23_2 == CharacterEnum.showAttributeOption.ShowMin then
		var_23_2 = 1
	else
		local var_23_3 = arg_23_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_23_0.viewParam.heroid)

		var_23_2 = arg_23_0._level or var_23_3.level

		if arg_23_0.viewParam.isBalance then
			var_23_2 = arg_23_0._balanceHelper.getHeroBalanceLv(var_23_3.heroId)
		end
	end

	local var_23_4 = tonumber(lua_fight_const.configDict[11].value)
	local var_23_5 = tonumber(lua_fight_const.configDict[12].value)
	local var_23_6 = (tonumber(lua_fight_const.configDict[13].value) + var_23_2 * tonumber(lua_fight_const.configDict[14].value) * 10) * 10
	local var_23_7 = string.format("%.1f", arg_23_1 * var_23_4 / var_23_6)
	local var_23_8 = string.format("%.1f", arg_23_1 * var_23_5 / var_23_6)

	return var_23_7, var_23_8
end

function var_0_0._getTotalUpAttributes(arg_24_0, arg_24_1)
	local var_24_0

	if arg_24_1 == CharacterEnum.showAttributeOption.ShowMax then
		local var_24_1 = CharacterModel.instance:getMaxRank(arg_24_0.viewParam.heroid)
		local var_24_2 = CharacterModel.instance:getrankEffects(arg_24_0.viewParam.heroid, var_24_1)[1]

		var_24_0 = SkillConfig.instance:getherolevelCO(arg_24_0.viewParam.heroid, var_24_2)
	elseif arg_24_1 == CharacterEnum.showAttributeOption.ShowMin then
		var_24_0 = SkillConfig.instance:getherolevelCO(arg_24_0.viewParam.heroid, 1)
	else
		var_24_0 = (arg_24_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_24_0.viewParam.heroid)):getHeroLevelConfig()
	end

	local var_24_3 = {}

	for iter_24_0, iter_24_1 in ipairs(CharacterEnum.UpAttrIdList) do
		var_24_3[iter_24_1] = var_24_0[CharacterEnum.AttrIdToAttrName[iter_24_1]] or 0
	end

	return var_24_3
end

function var_0_0._getMaxNormalAtrributes(arg_25_0)
	local var_25_0 = CharacterModel.instance:getMaxRank(arg_25_0.viewParam.heroid)
	local var_25_1 = CharacterModel.instance:getMaxLevel(arg_25_0.viewParam.heroid)
	local var_25_2 = SkillConfig.instance:getherolevelCO(arg_25_0.viewParam.heroid, var_25_1)
	local var_25_3 = SkillConfig.instance:getHeroRankAttribute(arg_25_0.viewParam.heroid, var_25_0)

	return {
		[CharacterEnum.AttrId.Attack] = var_25_2.atk + var_25_3.atk,
		[CharacterEnum.AttrId.Hp] = var_25_2.hp + var_25_3.hp,
		[CharacterEnum.AttrId.Defense] = var_25_2.def + var_25_3.def,
		[CharacterEnum.AttrId.Mdefense] = var_25_2.mdef + var_25_3.mdef,
		[CharacterEnum.AttrId.Technic] = var_25_2.technic + var_25_3.technic
	}
end

function var_0_0._getMinNormalAttribute(arg_26_0)
	local var_26_0 = SkillConfig.instance:getherolevelCO(arg_26_0.viewParam.heroid, 1)

	return {
		[CharacterEnum.AttrId.Attack] = var_26_0.atk,
		[CharacterEnum.AttrId.Hp] = var_26_0.hp,
		[CharacterEnum.AttrId.Defense] = var_26_0.def,
		[CharacterEnum.AttrId.Mdefense] = var_26_0.mdef,
		[CharacterEnum.AttrId.Technic] = var_26_0.technic
	}
end

function var_0_0._countRate(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	for iter_27_0 = 1, arg_27_3 - 1 do
		if arg_27_1 < arg_27_2[iter_27_0 + 1] then
			return iter_27_0
		end
	end

	return arg_27_3
end

function var_0_0._setPassiveSkill(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	arg_28_0._matchSkillNames = {}

	local var_28_0

	if arg_28_2 == CharacterEnum.showAttributeOption.ShowMax then
		var_28_0 = CharacterEnum.MaxSkillExLevel
	else
		var_28_0 = arg_28_2 == CharacterEnum.showAttributeOption.ShowMin and 0 or (arg_28_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_28_1)).exSkillLevel
	end

	local var_28_1 = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(arg_28_1, var_28_0)

	if arg_28_0.viewParam.heroMo and arg_28_0.viewParam.heroMo.trialAttrCo then
		var_28_1 = arg_28_0.viewParam.heroMo:getpassiveskillsCO()
	end

	local var_28_2 = arg_28_0:_checkDestinyEffect(var_28_1, arg_28_0.viewParam.heroMo)
	local var_28_3 = var_28_1[1].skillPassive

	arg_28_0._txtpassivename.text = lua_skill.configDict[var_28_3].name

	local var_28_4 = {}

	for iter_28_0 = 1, #var_28_2 do
		local var_28_5 = var_28_2[iter_28_0]
		local var_28_6 = lua_skill.configDict[var_28_5]
		local var_28_7 = HeroConfig.instance:getHeroCO(arg_28_1)
		local var_28_8 = FightConfig.instance:getSkillEffectDesc(var_28_7.name, var_28_6)

		table.insert(var_28_4, var_28_8)
	end

	local var_28_9 = HeroSkillModel.instance:getSkillEffectTagIdsFormDescTabRecursion(var_28_4)
	local var_28_10 = {}
	local var_28_11 = {}
	local var_28_12 = 0

	if arg_28_0.viewParam.isBalance then
		local var_28_13 = arg_28_0._balanceHelper.getHeroBalanceLv(arg_28_0.viewParam.heroMo.heroId)

		var_28_12 = SkillConfig.instance:getHeroExSkillLevelByLevel(arg_28_0.viewParam.heroMo.heroId, math.max(arg_28_0._level or arg_28_0.viewParam.heroMo.level, var_28_13))
	end

	for iter_28_1 = 1, #var_28_2 do
		local var_28_14 = var_28_2[iter_28_1]
		local var_28_15 = arg_28_0:_getPassiveUnlock(arg_28_2, arg_28_1, iter_28_1, arg_28_0.viewParam.heroMo)

		if arg_28_0.viewParam.isBalance then
			var_28_15 = iter_28_1 <= var_28_12
		end

		local var_28_16 = lua_skill.configDict[var_28_14]
		local var_28_17 = HeroConfig.instance:getHeroCO(arg_28_1)
		local var_28_18 = FightConfig.instance:getSkillEffectDesc(var_28_17.name, var_28_16)

		for iter_28_2, iter_28_3 in ipairs(var_28_9[iter_28_1]) do
			local var_28_19 = SkillConfig.instance:getSkillEffectDescCo(iter_28_3)
			local var_28_20 = var_28_19.name

			if HeroSkillModel.instance:canShowSkillTag(var_28_20, true) and not var_28_10[var_28_20] then
				var_28_10[var_28_20] = true

				if var_28_19.isSpecialCharacter == 1 then
					local var_28_21 = var_28_19.desc

					var_28_18 = string.format("%s", var_28_18)

					local var_28_22 = SkillHelper.buildDesc(var_28_21)

					table.insert(var_28_11, {
						desc = var_28_22,
						title = var_28_19.name
					})
				end
			end
		end

		local var_28_23 = SkillHelper.buildDesc(var_28_18)
		local var_28_24 = arg_28_0:_getTargetRankByEffect(arg_28_1, iter_28_1)

		if not var_28_15 then
			arg_28_0._passiveskillitems[iter_28_1].unlocktxt.text = string.format(luaLang("character_passive_get"), GameUtil.getRomanNums(var_28_24))

			SLFramework.UGUI.GuiHelper.SetColor(arg_28_0._passiveskillitems[iter_28_1].unlocktxt, "#3A3A3A")
		else
			arg_28_0._passiveskillitems[iter_28_1].unlocktxt.text = string.format(luaLang("character_passive_unlock"), GameUtil.getRomanNums(var_28_24))

			SLFramework.UGUI.GuiHelper.SetColor(arg_28_0._passiveskillitems[iter_28_1].unlocktxt, "#313B33")
		end

		arg_28_0._passiveskillitems[iter_28_1].canvasgroup.alpha = var_28_15 and 1 or 0.83

		gohelper.setActive(arg_28_0._passiveskillitems[iter_28_1].on, var_28_15)

		arg_28_0._passiveskillitems[iter_28_1].desc.text = var_28_23

		arg_28_0._passiveskillitems[iter_28_1].fixTmpBreakLine:refreshTmpContent(arg_28_0._passiveskillitems[iter_28_1].desc)
		SLFramework.UGUI.GuiHelper.SetColor(arg_28_0._passiveskillitems[iter_28_1].desc, var_28_15 and "#272525" or "#3A3A3A")
		gohelper.setActive(arg_28_0._passiveskillitems[iter_28_1].go, true)
		gohelper.setActive(arg_28_0._passiveskillitems[iter_28_1].connectline, iter_28_1 ~= #var_28_1)
	end

	for iter_28_4 = #var_28_1 + 1, #arg_28_0._passiveskillitems do
		gohelper.setActive(arg_28_0._passiveskillitems[iter_28_4].go, false)
	end

	arg_28_0:_showSkillEffectDesc(var_28_11)
	arg_28_0:_refreshPassiveSkillScroll()
	arg_28_0:_setTipPos(arg_28_0._gopassiveskilltip.transform, arg_28_4, arg_28_3)
end

function var_0_0._checkDestinyEffect(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = {}

	if arg_29_1 then
		for iter_29_0 = 1, #arg_29_1 do
			local var_29_1 = arg_29_1[iter_29_0].skillPassive

			table.insert(var_29_0, var_29_1)
		end

		if arg_29_2 and arg_29_2.destinyStoneMo then
			var_29_0 = arg_29_2.destinyStoneMo:_replaceSkill(var_29_0)
		end
	end

	return var_29_0
end

function var_0_0._setTipPos(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if not arg_30_1 then
		return
	end

	local var_30_0 = arg_30_3 and arg_30_3[1] or Vector2.New(0.5, 0.5)
	local var_30_1 = arg_30_3 and arg_30_3[2] or Vector2.New(0.5, 0.5)
	local var_30_2 = arg_30_2 and arg_30_2 or Vector2.New(0, 0)

	arg_30_0._gopassiveskilltip.transform.anchorMin = var_30_0
	arg_30_0._gopassiveskilltip.transform.anchorMax = var_30_1
	arg_30_0._goBuffItem.transform.anchorMin = var_30_0
	arg_30_0._goBuffItem.transform.anchorMax = var_30_1

	recthelper.setAnchor(arg_30_1, var_30_2.x, var_30_2.y)
	recthelper.setAnchorX(arg_30_0._goBuffItem.transform, arg_30_0.viewParam.buffTipsX or 0)
end

function var_0_0._refreshPassiveSkillScroll(arg_31_0)
	arg_31_0:_setScrollMaskVisible()

	local var_31_0 = gohelper.findChild(arg_31_0._gopassiveskilltip, "mask/root/scrollview/viewport")
	local var_31_1 = gohelper.onceAddComponent(var_31_0, gohelper.Type_VerticalLayoutGroup)
	local var_31_2 = gohelper.onceAddComponent(var_31_0, typeof(UnityEngine.UI.LayoutElement))
	local var_31_3 = recthelper.getHeight(var_31_0.transform)

	var_31_1.enabled = false
	var_31_2.enabled = true
	var_31_2.preferredHeight = var_31_3
end

function var_0_0._showSkillEffectDesc(arg_32_0, arg_32_1)
	gohelper.setActive(arg_32_0._goeffectdesc, arg_32_1 and #arg_32_1 > 0)

	for iter_32_0 = 1, #arg_32_1 do
		local var_32_0 = arg_32_1[iter_32_0]
		local var_32_1 = arg_32_0:_getSkillEffectDescItem(iter_32_0)

		var_32_1.desc.text = var_32_0.desc
		var_32_1.title.text = SkillHelper.removeRichTag(var_32_0.title)

		var_32_1.fixTmpBreakLine:refreshTmpContent(var_32_1.desc)
		gohelper.setActive(var_32_1.go, true)
	end

	for iter_32_1 = #arg_32_1 + 1, #arg_32_0._skillEffectDescItems do
		gohelper.setActive(arg_32_0._passiveskillitems[iter_32_1].go, false)
	end
end

function var_0_0._getSkillEffectDescItem(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0._skillEffectDescItems[arg_33_1]

	if not var_33_0 then
		var_33_0 = arg_33_0:getUserDataTb_()
		var_33_0.go = gohelper.cloneInPlace(arg_33_0._goeffectdescitem, "descitem" .. arg_33_1)
		var_33_0.desc = gohelper.findChildText(var_33_0.go, "effectdesc")
		var_33_0.title = gohelper.findChildText(var_33_0.go, "titlebg/bg/name")
		var_33_0.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_33_0.desc.gameObject, FixTmpBreakLine)
		var_33_0.hyperLinkClick = SkillHelper.addHyperLinkClick(var_33_0.desc, arg_33_0._onHyperLinkClick, arg_33_0)

		table.insert(arg_33_0._skillEffectDescItems, arg_33_1, var_33_0)
	end

	return var_33_0
end

var_0_0.LeftWidth = 470
var_0_0.RightWidth = 190
var_0_0.TopHeight = 292
var_0_0.Interval = 10

function var_0_0._onHyperLinkClick(arg_34_0, arg_34_1, arg_34_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(tonumber(arg_34_1), arg_34_0.setTipPosCallback, arg_34_0)
end

function var_0_0.setTipPosCallback(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0.rectTrPassive = arg_35_0.rectTrPassive or arg_35_0._gopassiveskilltip:GetComponent(gohelper.Type_RectTransform)

	local var_35_0 = GameUtil.getViewSize() / 2
	local var_35_1, var_35_2 = recthelper.uiPosToScreenPos2(arg_35_0.rectTrPassive)
	local var_35_3, var_35_4 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(var_35_1, var_35_2, arg_35_1, CameraMgr.instance:getUICamera(), nil, nil)
	local var_35_5 = var_35_0 + var_35_3 - var_0_0.LeftWidth - var_0_0.Interval
	local var_35_6 = recthelper.getWidth(arg_35_2)
	local var_35_7 = var_35_6 <= var_35_5

	arg_35_2.pivot = CommonBuffTipEnum.Pivot.Right

	local var_35_8 = var_35_3
	local var_35_9 = var_35_4

	if var_35_7 then
		var_35_8 = var_35_8 - var_0_0.LeftWidth - var_0_0.Interval
	else
		var_35_8 = var_35_8 + var_0_0.RightWidth + var_0_0.Interval + var_35_6
	end

	local var_35_10 = var_35_9 + var_0_0.TopHeight

	recthelper.setAnchor(arg_35_2, var_35_8, var_35_10)
end

function var_0_0._setScrollMaskVisible(arg_36_0)
	local var_36_0 = gohelper.findChild(arg_36_0._gopassiveskilltip, "mask/root")

	ZProj.UGUIHelper.RebuildLayout(var_36_0.transform)

	arg_36_0._couldScroll = recthelper.getHeight(arg_36_0._passiveskilltipcontent.transform) > recthelper.getHeight(arg_36_0._scrollview.transform)

	gohelper.setActive(arg_36_0._gomask1, arg_36_0._couldScroll and not (gohelper.getRemindFourNumberFloat(arg_36_0._scrollview.verticalNormalizedPosition) <= 0))

	arg_36_0._passiveskilltipmask.enabled = false
end

function var_0_0._getPassiveUnlock(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	if arg_37_1 == CharacterEnum.showAttributeOption.ShowMax then
		return true
	elseif arg_37_1 == CharacterEnum.showAttributeOption.ShowMin then
		return false
	elseif arg_37_4 then
		return CharacterModel.instance:isPassiveUnlockByHeroMo(arg_37_4, arg_37_3, arg_37_0._passiveSkillLevel)
	else
		return CharacterModel.instance:isPassiveUnlock(arg_37_2, arg_37_3)
	end
end

function var_0_0._getTargetRankByEffect(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = SkillConfig.instance:getheroranksCO(arg_38_1)

	for iter_38_0, iter_38_1 in pairs(var_38_0) do
		if CharacterModel.instance:getrankEffects(arg_38_1, iter_38_0)[2] == arg_38_2 then
			return iter_38_0 - 1
		end
	end

	return 0
end

function var_0_0.showDetail(arg_39_0, arg_39_1)
	arg_39_0._isOpenAttrDesc = not arg_39_0._isOpenAttrDesc

	gohelper.setActive(arg_39_0._godetailcontent, arg_39_0._isOpenAttrDesc)

	if not arg_39_0._isOpenAttrDesc then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_role_description)

	local var_39_0 = recthelper.rectToRelativeAnchorPos(arg_39_1.go.transform.position, arg_39_0._goattributetip.transform)

	if var_39_0.y < var_0_0.DetailClickMinPos then
		recthelper.setAnchorY(arg_39_0._godetailcontent.transform, var_0_0.DetailBottomPos)
	else
		recthelper.setAnchorY(arg_39_0._godetailcontent.transform, var_39_0.y + var_0_0.DetailOffset)
	end

	local var_39_1 = HeroConfig.instance:getHeroAttributeCO(arg_39_1.attributeId)

	arg_39_0._txtDetailItemName.text = var_39_1.name

	CharacterController.instance:SetAttriIcon(arg_39_0._txtDetailItemIcon, arg_39_1.icon, GameUtil.parseColor("#975129"))

	local var_39_2 = string.split(var_39_1.desc, "|")

	for iter_39_0, iter_39_1 in ipairs(var_39_2) do
		local var_39_3 = arg_39_0._detailDescTab[iter_39_0]

		if not var_39_3 then
			var_39_3 = gohelper.clone(arg_39_0._txtDetailItemDesc.gameObject, arg_39_0._goattributecontentitem, "descItem")

			gohelper.setActive(var_39_3, false)
			table.insert(arg_39_0._detailDescTab, var_39_3)
		end

		gohelper.setActive(var_39_3, true)

		var_39_3:GetComponent(gohelper.Type_TextMesh).text = iter_39_1
	end

	for iter_39_2 = #var_39_2 + 1, #arg_39_0._detailDescTab do
		gohelper.setActive(arg_39_0._detailDescTab[iter_39_2], false)
	end
end

function var_0_0.onClose(arg_40_0)
	for iter_40_0, iter_40_1 in pairs(arg_40_0._detailClickItems) do
		iter_40_1:RemoveClickListener()
	end
end

return var_0_0
