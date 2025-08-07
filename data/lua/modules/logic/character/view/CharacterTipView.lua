module("modules.logic.character.view.CharacterTipView", package.seeall)

local var_0_0 = class("CharacterTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goattributetip = gohelper.findChild(arg_1_0.viewGO, "#go_attributetip")
	arg_1_0._goattrassassinbg = gohelper.findChild(arg_1_0.viewGO, "#go_attributetip/skillbgassassin")
	arg_1_0._btnbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_attributetip/scrollview/viewport/#btn_bg")
	arg_1_0._goattributecontent = gohelper.findChild(arg_1_0.viewGO, "#go_attributetip/scrollview/viewport/content")
	arg_1_0._godetailcontent = gohelper.findChild(arg_1_0.viewGO, "#go_attributetip/#go_detailContent")
	arg_1_0._goattributecontentitem = gohelper.findChild(arg_1_0.viewGO, "#go_attributetip/#go_detailContent/detailscroll/Viewport/#go_attributeContent/#go_attributeItem")
	arg_1_0._gopassiveskilltip = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip")
	arg_1_0._goeffectdesc = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc")
	arg_1_0._goeffectdescitem = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc/#go_effectdescitem")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview")
	arg_1_0._gopassiveassassinbg = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview/skillbgassassin")
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
		arg_8_0._passiveskillitems[iter_8_2] = arg_8_0:_findPassiveskillitems(iter_8_2)
	end

	arg_8_0._passiveskillitems[0] = arg_8_0:_findPassiveskillitems(4)
	arg_8_0._txtpassivename = gohelper.findChildText(arg_8_0.viewGO, "#go_passiveskilltip/name/bg/#txt_passivename")
	arg_8_0._detailClickItems = {}
	arg_8_0._detailDescTab = arg_8_0:getUserDataTb_()
	arg_8_0._skillEffectDescItems = arg_8_0:getUserDataTb_()

	arg_8_0._simageshadow:LoadImage(ResUrl.getCharacterIcon("bg_shade"))
end

function var_0_0._findPassiveskillitems(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.go = gohelper.findChild(arg_9_0._gopassiveskilltip, "mask/root/scrollview/viewport/content/talentstar" .. arg_9_1)
	var_9_0.desc = gohelper.findChildTextMesh(var_9_0.go, "desctxt")
	var_9_0.hyperLinkClick = SkillHelper.addHyperLinkClick(var_9_0.desc, arg_9_0._onHyperLinkClick, arg_9_0)
	var_9_0.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_0.desc.gameObject, FixTmpBreakLine)
	var_9_0.on = gohelper.findChild(var_9_0.go, "#go_passiveskills/passiveskill/on")
	var_9_0.unlocktxt = gohelper.findChildText(var_9_0.go, "#go_passiveskills/passiveskill/unlocktxt")
	var_9_0.canvasgroup = gohelper.onceAddComponent(var_9_0.go, typeof(UnityEngine.CanvasGroup))
	var_9_0.connectline = gohelper.findChild(var_9_0.go, "line")

	return var_9_0
end

function var_0_0._getAttrUpperItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._attrupperitems[arg_10_1]

	if not var_10_0 then
		var_10_0 = arg_10_0:getUserDataTb_()
		var_10_0.go = gohelper.clone(arg_10_0.goattrupperitem, arg_10_0.gocontent, "attrupper" .. arg_10_1)

		gohelper.setActive(var_10_0.go, true)

		var_10_0.value = gohelper.findChildText(var_10_0.go, "value")
		var_10_0.addValue = gohelper.findChildText(var_10_0.go, "addvalue")
		var_10_0.name = gohelper.findChildText(var_10_0.go, "name")
		var_10_0.icon = gohelper.findChildImage(var_10_0.go, "icon")
		var_10_0.detail = gohelper.findChild(var_10_0.go, "btndetail")
		arg_10_0._attrupperitems[arg_10_1] = var_10_0
	end

	return var_10_0
end

function var_0_0._setTitleText(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = gohelper.findChildText(arg_11_1, "attcn")

	if var_11_0 then
		var_11_0.text = arg_11_2
	end

	local var_11_1 = gohelper.findChildText(arg_11_1, "atten")

	if var_11_1 then
		var_11_1.text = arg_11_3
	end
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simageshadow:UnLoadImage()
end

function var_0_0.onOpen(arg_14_0)
	gohelper.setActive(arg_14_0._godetailcontent, false)

	local var_14_0 = arg_14_0.viewParam

	arg_14_0.heroId = arg_14_0.viewParam.heroid
	arg_14_0._level = arg_14_0.viewParam.level
	arg_14_0._rank = arg_14_0.viewParam.rank
	arg_14_0._passiveSkillLevel = arg_14_0.viewParam.passiveSkillLevel
	arg_14_0._setEquipInfo = arg_14_0.viewParam.setEquipInfo
	arg_14_0._talentCubeInfos = arg_14_0.viewParam.talentCubeInfos
	arg_14_0._balanceHelper = arg_14_0.viewParam.balanceHelper or HeroGroupBalanceHelper
	arg_14_0._hideAttrDetail = arg_14_0.viewParam.hideAttrDetail

	gohelper.setActive(arg_14_0.goDescTitle, true)
	gohelper.setActive(arg_14_0.goTotalTitle, true)
	gohelper.setActive(arg_14_0._goattributetip, var_14_0.tag == "attribute")
	gohelper.setActive(arg_14_0._gopassiveskilltip, var_14_0.tag == "passiveskill")
	gohelper.setActive(arg_14_0._goattrassassinbg, var_14_0.showAssassinBg)
	gohelper.setActive(arg_14_0._gopassiveassassinbg, var_14_0.showAssassinBg)

	var_14_0.showAttributeOption = var_14_0.showAttributeOption or CharacterEnum.showAttributeOption.ShowCurrent

	if var_14_0.tag == "attribute" then
		arg_14_0:_setAttribute(var_14_0.equips, var_14_0.showAttributeOption, var_14_0.anchorParams, var_14_0.tipPos)
	elseif var_14_0.tag == "passiveskill" then
		arg_14_0:_setPassiveSkill(var_14_0.heroid, var_14_0.showAttributeOption, var_14_0.anchorParams, var_14_0.tipPos)
	end
end

function var_0_0._setAttribute(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	for iter_15_0 = 7, 11 do
		gohelper.setActive(arg_15_0._attrupperitems[iter_15_0].go, false)
	end

	arg_15_0:refreshBaseAttrItem(arg_15_1, arg_15_2)
	arg_15_0:refreshUpAttrItem(arg_15_1, arg_15_2)
	arg_15_0:_setTipPos(arg_15_0._goattributetip.transform, arg_15_4, arg_15_3)
end

function var_0_0.refreshBaseAttrItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getBaseAttrValueList(arg_16_2)
	local var_16_1 = arg_16_0:getEquipAddBaseValues(arg_16_1, var_16_0)
	local var_16_2 = arg_16_0:getTalentValues(arg_16_2)
	local var_16_3 = arg_16_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_16_0.heroId)
	local var_16_4 = var_16_3 and var_16_3.destinyStoneMo
	local var_16_5 = var_16_4 and var_16_4:getAddAttrValues()

	for iter_16_0, iter_16_1 in ipairs(CharacterEnum.BaseAttrIdList) do
		local var_16_6 = HeroConfig.instance:getHeroAttributeCO(iter_16_1)
		local var_16_7 = var_16_4 and var_16_4:getAddValueByAttrId(var_16_5, iter_16_1, var_16_3) or 0
		local var_16_8 = var_16_1[iter_16_1] + (var_16_2[iter_16_1] and var_16_2[iter_16_1].value or 0) + var_16_7

		arg_16_0._attnormalitems[iter_16_0].value.text = var_16_0[iter_16_1]
		arg_16_0._attnormalitems[iter_16_0].addValue.text = var_16_8 == 0 and "" or "+" .. var_16_8
		arg_16_0._attnormalitems[iter_16_0].name.text = var_16_6.name

		CharacterController.instance:SetAttriIcon(arg_16_0._attnormalitems[iter_16_0].icon, iter_16_1, GameUtil.parseColor("#323c34"))

		if var_16_6.isShowTips == 1 and not arg_16_0._hideAttrDetail then
			local var_16_9 = {
				attributeId = var_16_6.id,
				icon = iter_16_1,
				go = arg_16_0._attnormalitems[iter_16_0].go
			}
			local var_16_10 = gohelper.getClick(arg_16_0._attnormalitems[iter_16_0].detail)

			var_16_10:AddClickListener(arg_16_0.showDetail, arg_16_0, var_16_9)
			table.insert(arg_16_0._detailClickItems, var_16_10)
			gohelper.setActive(arg_16_0._attnormalitems[iter_16_0].detail, true)
		else
			gohelper.setActive(arg_16_0._attnormalitems[iter_16_0].detail, false)
		end

		if arg_16_0._attnormalitems[iter_16_0].withDesc then
			local var_16_11, var_16_12 = arg_16_0:calculateTechnic(var_16_0[CharacterEnum.AttrId.Technic], arg_16_2)
			local var_16_13 = CommonConfig.instance:getConstStr(ConstEnum.CharacterTechnicDesc)
			local var_16_14 = string.gsub(var_16_13, "▩1%%s", var_16_11)
			local var_16_15 = string.gsub(var_16_14, "▩2%%s", var_16_12)

			arg_16_0._attnormalitems[iter_16_0].desc.text = var_16_15
		end
	end
end

function var_0_0.refreshUpAttrItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getBaseAttrValueList(arg_17_2)
	local var_17_1 = arg_17_0:_getTotalUpAttributes(arg_17_2)
	local var_17_2 = arg_17_0:getEquipBreakAddAttrValues(arg_17_1)
	local var_17_3 = arg_17_0:getTalentValues(arg_17_2)
	local var_17_4 = arg_17_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_17_0.heroId)
	local var_17_5 = var_17_4 and var_17_4.destinyStoneMo
	local var_17_6 = var_17_5 and var_17_5:getAddAttrValues()
	local var_17_7, var_17_8 = arg_17_0:calculateTechnic(var_17_0[CharacterEnum.AttrId.Technic], arg_17_2)
	local var_17_9 = 1

	for iter_17_0, iter_17_1 in ipairs(CharacterEnum.UpAttrIdList) do
		gohelper.setActive(arg_17_0._attrupperitems[iter_17_0].go, true)

		local var_17_10 = HeroConfig.instance:getHeroAttributeCO(iter_17_1)
		local var_17_11 = var_17_5 and var_17_5:getAddValueByAttrId(var_17_6, iter_17_1, var_17_4) or 0
		local var_17_12 = var_17_2[iter_17_1] + (var_17_3[iter_17_1] and var_17_3[iter_17_1].value or 0) + var_17_11
		local var_17_13 = (var_17_1[iter_17_1] or 0) / 10

		if iter_17_1 == CharacterEnum.AttrId.Cri then
			var_17_13 = var_17_13 + var_17_7
		end

		if iter_17_1 == CharacterEnum.AttrId.CriDmg then
			var_17_13 = var_17_13 + var_17_8
		end

		local var_17_14 = tostring(GameUtil.noMoreThanOneDecimalPlace(var_17_13)) .. "%"

		arg_17_0._attrupperitems[iter_17_0].value.text = var_17_14
		arg_17_0._attrupperitems[iter_17_0].addValue.text = var_17_12 == 0 and "" or "+" .. tostring(GameUtil.noMoreThanOneDecimalPlace(var_17_12)) .. "%"
		arg_17_0._attrupperitems[iter_17_0].name.text = var_17_10.name

		CharacterController.instance:SetAttriIcon(arg_17_0._attrupperitems[iter_17_0].icon, iter_17_1, var_0_0.AttrColor)

		if var_17_10.isShowTips == 1 and not arg_17_0._hideAttrDetail then
			local var_17_15 = {
				attributeId = var_17_10.id,
				icon = iter_17_1,
				go = arg_17_0._attrupperitems[iter_17_0].go
			}
			local var_17_16 = gohelper.getClick(arg_17_0._attrupperitems[iter_17_0].detail)

			var_17_16:AddClickListener(arg_17_0.showDetail, arg_17_0, var_17_15)
			table.insert(arg_17_0._detailClickItems, var_17_16)
			gohelper.setActive(arg_17_0._attrupperitems[iter_17_0].detail, true)
		else
			gohelper.setActive(arg_17_0._attrupperitems[iter_17_0].detail, false)
		end

		var_17_9 = var_17_9 + 1
	end

	for iter_17_2, iter_17_3 in ipairs(CharacterDestinyEnum.DestinyUpSpecialAttr) do
		local var_17_17 = var_17_5 and var_17_5:getAddValueByAttrId(var_17_6, iter_17_3, var_17_4) or 0

		if var_17_17 ~= 0 then
			local var_17_18 = arg_17_0:_getAttrUpperItem(var_17_9)

			gohelper.setActive(var_17_18.go, true)

			local var_17_19 = HeroConfig.instance:getHeroAttributeCO(iter_17_3)

			var_17_18.value.text = 0

			local var_17_20 = "+" .. tostring(GameUtil.noMoreThanOneDecimalPlace(var_17_17)) .. "%"

			var_17_18.addValue.text = var_17_17 == 0 and "" or var_17_20
			var_17_18.name.text = var_17_19.name

			CharacterController.instance:SetAttriIcon(var_17_18.icon, iter_17_3, var_0_0.AttrColor)

			if var_17_19.isShowTips == 1 then
				local var_17_21 = {
					attributeId = var_17_19.id,
					icon = iter_17_3,
					go = var_17_18.go
				}
				local var_17_22 = gohelper.getClick(var_17_18.detail)

				var_17_22:AddClickListener(arg_17_0.showDetail, arg_17_0, var_17_21)
				table.insert(arg_17_0._detailClickItems, var_17_22)
				gohelper.setActive(var_17_18.detail, true)
			else
				gohelper.setActive(var_17_18.detail, false)
			end

			var_17_9 = var_17_9 + 1
		end
	end
end

function var_0_0.getBaseAttrValueList(arg_18_0, arg_18_1)
	local var_18_0 = {}

	if arg_18_1 == CharacterEnum.showAttributeOption.ShowMax then
		var_18_0 = arg_18_0:_getMaxNormalAtrributes()
	elseif arg_18_1 == CharacterEnum.showAttributeOption.ShowMin then
		var_18_0 = arg_18_0:_getMinNormalAttribute()
	else
		local var_18_1 = arg_18_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_18_0.heroId)
		local var_18_2 = arg_18_0._level
		local var_18_3 = arg_18_0._rank

		if arg_18_0.viewParam.isBalance then
			var_18_2 = arg_18_0._balanceHelper.getHeroBalanceLv(var_18_1.heroId)
			_, var_18_3 = HeroConfig.instance:getShowLevel(var_18_2)
		end

		var_18_0 = var_18_1:getHeroBaseAttrDict(var_18_2, var_18_3)
	end

	return var_18_0
end

function var_0_0.getEquipAddBaseValues(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = {}
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(CharacterEnum.BaseAttrIdList) do
		var_19_0[iter_19_1] = 0
		var_19_1[iter_19_1] = 0
	end

	local var_19_2

	if arg_19_0.viewParam.isBalance then
		_, _, var_19_2 = arg_19_0._balanceHelper.getBalanceLv()
	end

	local var_19_3 = arg_19_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_19_0.heroId)

	if arg_19_1 then
		if arg_19_0.viewParam.trialEquipMo then
			var_19_3:_calcEquipAttr(arg_19_0.viewParam.trialEquipMo, var_19_0, var_19_1)
		end

		for iter_19_2 = 1, #arg_19_1 do
			local var_19_4 = EquipModel.instance:getEquip(arg_19_1[iter_19_2])

			var_19_4 = var_19_4 and arg_19_0:_modifyEquipInfo(var_19_4)

			var_19_3:_calcEquipAttr(var_19_4, var_19_0, var_19_1, var_19_2)
		end
	end

	for iter_19_3, iter_19_4 in ipairs(CharacterEnum.BaseAttrIdList) do
		var_19_0[iter_19_4] = var_19_0[iter_19_4] + math.floor(var_19_1[iter_19_4] / 1000 * arg_19_2[iter_19_4])
	end

	return var_19_0
end

function var_0_0._modifyEquipInfo(arg_20_0, arg_20_1)
	if arg_20_0._setEquipInfo then
		local var_20_0 = arg_20_0._setEquipInfo[1]
		local var_20_1 = arg_20_0._setEquipInfo[2]
		local var_20_2 = arg_20_0._setEquipInfo[3]

		if var_20_2 and var_20_2.isCachot then
			return var_20_0(var_20_1, {
				seatLevel = var_20_2.seatLevel,
				equipMO = arg_20_1
			})
		end
	end

	return arg_20_1
end

function var_0_0.getTalentValues(arg_21_0, arg_21_1)
	local var_21_0 = {}

	if arg_21_1 == CharacterEnum.showAttributeOption.ShowCurrent then
		local var_21_1 = arg_21_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_21_0.heroId)

		if arg_21_0.viewParam.isBalance then
			local var_21_2, var_21_3, var_21_4, var_21_5 = arg_21_0._balanceHelper.getHeroBalanceInfo(var_21_1.heroId)

			var_21_0 = var_21_1:getTalentGain(var_21_2, var_21_3, nil, var_21_5)
		else
			var_21_0 = var_21_1:getTalentGain(arg_21_0._level or var_21_1.level, arg_21_0._rank, nil, arg_21_0._talentCubeInfos)
		end

		var_21_0 = HeroConfig.instance:talentGainTab2IDTab(var_21_0)

		for iter_21_0, iter_21_1 in pairs(var_21_0) do
			if HeroConfig.instance:getHeroAttributeCO(iter_21_0).type ~= 1 then
				var_21_0[iter_21_0].value = var_21_0[iter_21_0].value / 10
			else
				var_21_0[iter_21_0].value = math.floor(var_21_0[iter_21_0].value)
			end
		end
	end

	return var_21_0
end

function var_0_0.getDestinyStoneAddValues(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_22_0.heroId)

	if var_22_0 then
		local var_22_1 = var_22_0.destinyStoneMo

		if var_22_1 then
			return var_22_1:getAddAttrValues()
		end
	end
end

function var_0_0.getEquipBreakAddAttrValues(arg_23_0, arg_23_1)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(CharacterEnum.BaseAttrIdList) do
		var_23_0[iter_23_1] = 0
	end

	for iter_23_2, iter_23_3 in ipairs(CharacterEnum.UpAttrIdList) do
		var_23_0[iter_23_3] = 0
	end

	if arg_23_1 and arg_23_0.viewParam.heroMo and arg_23_0.viewParam.trialEquipMo then
		local var_23_1 = arg_23_0.viewParam.trialEquipMo
		local var_23_2, var_23_3 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(var_23_1.config, var_23_1.breakLv)

		if var_23_2 then
			var_23_0[var_23_2] = var_23_0[var_23_2] + var_23_3
		end
	end

	if arg_23_1 and #arg_23_1 > 0 then
		for iter_23_4, iter_23_5 in ipairs(arg_23_1) do
			local var_23_4 = EquipModel.instance:getEquip(iter_23_5)

			if var_23_4 then
				local var_23_5 = arg_23_0:_modifyEquipInfo(var_23_4)
				local var_23_6, var_23_7 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(var_23_5.config, var_23_5.breakLv)

				if var_23_6 then
					var_23_0[var_23_6] = var_23_0[var_23_6] + var_23_7
				end
			end
		end
	end

	for iter_23_6, iter_23_7 in pairs(var_23_0) do
		var_23_0[iter_23_6] = iter_23_7 / 10
	end

	return var_23_0
end

function var_0_0.calculateTechnic(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0
	local var_24_1
	local var_24_2

	if arg_24_2 == CharacterEnum.showAttributeOption.ShowMax then
		var_24_2 = CharacterModel.instance:getMaxLevel(arg_24_0.viewParam.heroid)
	elseif arg_24_2 == CharacterEnum.showAttributeOption.ShowMin then
		var_24_2 = 1
	else
		local var_24_3 = arg_24_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_24_0.viewParam.heroid)

		var_24_2 = arg_24_0._level or var_24_3.level

		if arg_24_0.viewParam.isBalance then
			var_24_2 = arg_24_0._balanceHelper.getHeroBalanceLv(var_24_3.heroId)
		end
	end

	local var_24_4 = tonumber(lua_fight_const.configDict[11].value)
	local var_24_5 = tonumber(lua_fight_const.configDict[12].value)
	local var_24_6 = (tonumber(lua_fight_const.configDict[13].value) + var_24_2 * tonumber(lua_fight_const.configDict[14].value) * 10) * 10
	local var_24_7 = string.format("%.1f", arg_24_1 * var_24_4 / var_24_6)
	local var_24_8 = string.format("%.1f", arg_24_1 * var_24_5 / var_24_6)

	return var_24_7, var_24_8
end

function var_0_0._getTotalUpAttributes(arg_25_0, arg_25_1)
	local var_25_0

	if arg_25_1 == CharacterEnum.showAttributeOption.ShowMax then
		local var_25_1 = CharacterModel.instance:getMaxRank(arg_25_0.viewParam.heroid)
		local var_25_2 = CharacterModel.instance:getrankEffects(arg_25_0.viewParam.heroid, var_25_1)[1]

		var_25_0 = SkillConfig.instance:getherolevelCO(arg_25_0.viewParam.heroid, var_25_2)
	elseif arg_25_1 == CharacterEnum.showAttributeOption.ShowMin then
		var_25_0 = SkillConfig.instance:getherolevelCO(arg_25_0.viewParam.heroid, 1)
	else
		var_25_0 = (arg_25_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_25_0.viewParam.heroid)):getHeroLevelConfig()
	end

	local var_25_3 = {}

	for iter_25_0, iter_25_1 in ipairs(CharacterEnum.UpAttrIdList) do
		var_25_3[iter_25_1] = var_25_0[CharacterEnum.AttrIdToAttrName[iter_25_1]] or 0
	end

	return var_25_3
end

function var_0_0._getMaxNormalAtrributes(arg_26_0)
	local var_26_0 = CharacterModel.instance:getMaxRank(arg_26_0.viewParam.heroid)
	local var_26_1 = CharacterModel.instance:getMaxLevel(arg_26_0.viewParam.heroid)
	local var_26_2 = SkillConfig.instance:getherolevelCO(arg_26_0.viewParam.heroid, var_26_1)
	local var_26_3 = SkillConfig.instance:getHeroRankAttribute(arg_26_0.viewParam.heroid, var_26_0)

	return {
		[CharacterEnum.AttrId.Attack] = var_26_2.atk + var_26_3.atk,
		[CharacterEnum.AttrId.Hp] = var_26_2.hp + var_26_3.hp,
		[CharacterEnum.AttrId.Defense] = var_26_2.def + var_26_3.def,
		[CharacterEnum.AttrId.Mdefense] = var_26_2.mdef + var_26_3.mdef,
		[CharacterEnum.AttrId.Technic] = var_26_2.technic + var_26_3.technic
	}
end

function var_0_0._getMinNormalAttribute(arg_27_0)
	local var_27_0 = SkillConfig.instance:getherolevelCO(arg_27_0.viewParam.heroid, 1)

	return {
		[CharacterEnum.AttrId.Attack] = var_27_0.atk,
		[CharacterEnum.AttrId.Hp] = var_27_0.hp,
		[CharacterEnum.AttrId.Defense] = var_27_0.def,
		[CharacterEnum.AttrId.Mdefense] = var_27_0.mdef,
		[CharacterEnum.AttrId.Technic] = var_27_0.technic
	}
end

function var_0_0._countRate(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	for iter_28_0 = 1, arg_28_3 - 1 do
		if arg_28_1 < arg_28_2[iter_28_0 + 1] then
			return iter_28_0
		end
	end

	return arg_28_3
end

function var_0_0._setPassiveSkill(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	arg_29_0._matchSkillNames = {}

	local var_29_0

	if arg_29_2 == CharacterEnum.showAttributeOption.ShowMax then
		var_29_0 = CharacterEnum.MaxSkillExLevel
	else
		var_29_0 = arg_29_2 == CharacterEnum.showAttributeOption.ShowMin and 0 or (arg_29_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_29_1)).exSkillLevel
	end

	local var_29_1 = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(arg_29_1, var_29_0)

	if arg_29_0.viewParam.heroMo and arg_29_0.viewParam.heroMo.trialAttrCo then
		var_29_1 = arg_29_0.viewParam.heroMo:getpassiveskillsCO()
	end

	local var_29_2 = arg_29_0:_checkReplaceSkill(var_29_1, arg_29_0.viewParam.heroMo)
	local var_29_3 = var_29_1[1].skillPassive

	arg_29_0._txtpassivename.text = lua_skill.configDict[var_29_3].name

	local var_29_4 = HeroConfig.instance:getHeroCO(arg_29_1)
	local var_29_5 = {}

	for iter_29_0, iter_29_1 in pairs(var_29_2) do
		local var_29_6 = lua_skill.configDict[iter_29_1]

		var_29_5[iter_29_0] = FightConfig.instance:getSkillEffectDesc(var_29_4.name, var_29_6)
	end

	local var_29_7 = HeroSkillModel.instance:getSkillEffectTagIdsFormDescTabRecursion(var_29_5)
	local var_29_8 = {}
	local var_29_9 = {}
	local var_29_10 = 0

	if arg_29_0.viewParam.isBalance then
		local var_29_11 = arg_29_0._balanceHelper.getHeroBalanceLv(arg_29_0.viewParam.heroMo.heroId)

		var_29_10 = SkillConfig.instance:getHeroExSkillLevelByLevel(arg_29_0.viewParam.heroMo.heroId, math.max(arg_29_0._level or arg_29_0.viewParam.heroMo.level, var_29_11))
	end

	for iter_29_2, iter_29_3 in pairs(var_29_2) do
		if iter_29_3 then
			local var_29_12 = true

			if iter_29_2 ~= 0 then
				var_29_12 = arg_29_0:_getPassiveUnlock(arg_29_2, arg_29_1, iter_29_2, arg_29_0.viewParam.heroMo)

				if arg_29_0.viewParam.isBalance then
					var_29_12 = iter_29_2 <= var_29_10
				end
			end

			local var_29_13 = lua_skill.configDict[iter_29_3]
			local var_29_14 = FightConfig.instance:getSkillEffectDesc(var_29_4.name, var_29_13)

			for iter_29_4, iter_29_5 in ipairs(var_29_7[iter_29_2]) do
				local var_29_15 = SkillConfig.instance:getSkillEffectDescCo(iter_29_5)
				local var_29_16 = var_29_15.name

				if HeroSkillModel.instance:canShowSkillTag(var_29_16, true) and not var_29_8[var_29_16] then
					var_29_8[var_29_16] = true

					if var_29_15.isSpecialCharacter == 1 then
						local var_29_17 = var_29_15.desc

						var_29_14 = string.format("%s", var_29_14)

						local var_29_18 = SkillHelper.buildDesc(var_29_17)

						table.insert(var_29_9, {
							desc = var_29_18,
							title = var_29_15.name
						})
					end
				end
			end

			local var_29_19 = SkillHelper.buildDesc(var_29_14)
			local var_29_20 = arg_29_0:_getTargetRankByEffect(arg_29_1, iter_29_2)

			if not var_29_12 then
				arg_29_0._passiveskillitems[iter_29_2].unlocktxt.text = string.format(luaLang("character_passive_get"), GameUtil.getRomanNums(var_29_20))

				SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._passiveskillitems[iter_29_2].unlocktxt, "#3A3A3A")
			else
				local var_29_21

				if iter_29_2 == 0 then
					var_29_21 = luaLang("character_skill_passive_0")
				else
					var_29_21 = string.format(luaLang("character_passive_unlock"), GameUtil.getRomanNums(var_29_20))
				end

				arg_29_0._passiveskillitems[iter_29_2].unlocktxt.text = var_29_21

				SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._passiveskillitems[iter_29_2].unlocktxt, "#313B33")
			end

			arg_29_0._passiveskillitems[iter_29_2].canvasgroup.alpha = var_29_12 and 1 or 0.83

			gohelper.setActive(arg_29_0._passiveskillitems[iter_29_2].on, var_29_12)

			arg_29_0._passiveskillitems[iter_29_2].desc.text = var_29_19

			arg_29_0._passiveskillitems[iter_29_2].fixTmpBreakLine:refreshTmpContent(arg_29_0._passiveskillitems[iter_29_2].desc)
			SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._passiveskillitems[iter_29_2].desc, var_29_12 and "#272525" or "#3A3A3A")
			gohelper.setActive(arg_29_0._passiveskillitems[iter_29_2].go, true)
			gohelper.setActive(arg_29_0._passiveskillitems[iter_29_2].connectline, iter_29_2 ~= #var_29_1)
		else
			gohelper.setActive(arg_29_0._passiveskillitems[iter_29_2].go, false)
		end
	end

	for iter_29_6 = #var_29_1 + 1, #arg_29_0._passiveskillitems do
		gohelper.setActive(arg_29_0._passiveskillitems[iter_29_6].go, false)
	end

	gohelper.setActive(arg_29_0._passiveskillitems[0].go, var_29_2[0] ~= nil)
	arg_29_0:_showSkillEffectDesc(var_29_9)
	arg_29_0:_refreshPassiveSkillScroll()
	arg_29_0:_setTipPos(arg_29_0._gopassiveskilltip.transform, arg_29_4, arg_29_3)
end

function var_0_0._checkReplaceSkill(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = {}

	if arg_30_1 then
		for iter_30_0, iter_30_1 in pairs(arg_30_1) do
			var_30_0[iter_30_0] = iter_30_1.skillPassive
		end

		if arg_30_2 then
			var_30_0 = arg_30_2:checkReplaceSkill(var_30_0)
		end
	end

	return var_30_0
end

function var_0_0._setTipPos(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if not arg_31_1 then
		return
	end

	local var_31_0 = arg_31_3 and arg_31_3[1] or Vector2.New(0.5, 0.5)
	local var_31_1 = arg_31_3 and arg_31_3[2] or Vector2.New(0.5, 0.5)
	local var_31_2 = arg_31_2 and arg_31_2 or Vector2.New(0, 0)

	arg_31_1.anchorMin = var_31_0
	arg_31_1.anchorMax = var_31_1
	arg_31_0._goBuffItem.transform.anchorMin = var_31_0
	arg_31_0._goBuffItem.transform.anchorMax = var_31_1

	recthelper.setAnchor(arg_31_1, var_31_2.x, var_31_2.y)
	recthelper.setAnchorX(arg_31_0._goBuffItem.transform, arg_31_0.viewParam.buffTipsX or 0)
end

function var_0_0._refreshPassiveSkillScroll(arg_32_0)
	arg_32_0:_setScrollMaskVisible()

	local var_32_0 = gohelper.findChild(arg_32_0._gopassiveskilltip, "mask/root/scrollview/viewport")
	local var_32_1 = gohelper.onceAddComponent(var_32_0, gohelper.Type_VerticalLayoutGroup)
	local var_32_2 = gohelper.onceAddComponent(var_32_0, typeof(UnityEngine.UI.LayoutElement))
	local var_32_3 = recthelper.getHeight(var_32_0.transform)

	var_32_1.enabled = false
	var_32_2.enabled = true
	var_32_2.preferredHeight = var_32_3
end

function var_0_0._showSkillEffectDesc(arg_33_0, arg_33_1)
	gohelper.setActive(arg_33_0._goeffectdesc, arg_33_1 and #arg_33_1 > 0)

	for iter_33_0 = 1, #arg_33_1 do
		local var_33_0 = arg_33_1[iter_33_0]
		local var_33_1 = arg_33_0:_getSkillEffectDescItem(iter_33_0)

		var_33_1.desc.text = var_33_0.desc
		var_33_1.title.text = SkillHelper.removeRichTag(var_33_0.title)

		var_33_1.fixTmpBreakLine:refreshTmpContent(var_33_1.desc)
		gohelper.setActive(var_33_1.go, true)
	end

	for iter_33_1 = #arg_33_1 + 1, #arg_33_0._skillEffectDescItems do
		gohelper.setActive(arg_33_0._passiveskillitems[iter_33_1].go, false)
	end
end

function var_0_0._getSkillEffectDescItem(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0._skillEffectDescItems[arg_34_1]

	if not var_34_0 then
		var_34_0 = arg_34_0:getUserDataTb_()
		var_34_0.go = gohelper.cloneInPlace(arg_34_0._goeffectdescitem, "descitem" .. arg_34_1)
		var_34_0.desc = gohelper.findChildText(var_34_0.go, "effectdesc")
		var_34_0.title = gohelper.findChildText(var_34_0.go, "titlebg/bg/name")
		var_34_0.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_34_0.desc.gameObject, FixTmpBreakLine)
		var_34_0.hyperLinkClick = SkillHelper.addHyperLinkClick(var_34_0.desc, arg_34_0._onHyperLinkClick, arg_34_0)

		table.insert(arg_34_0._skillEffectDescItems, arg_34_1, var_34_0)
	end

	return var_34_0
end

var_0_0.LeftWidth = 470
var_0_0.RightWidth = 190
var_0_0.TopHeight = 292
var_0_0.Interval = 10

function var_0_0._onHyperLinkClick(arg_35_0, arg_35_1, arg_35_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(tonumber(arg_35_1), arg_35_0.setTipPosCallback, arg_35_0)
end

function var_0_0.setTipPosCallback(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0.rectTrPassive = arg_36_0.rectTrPassive or arg_36_0._gopassiveskilltip:GetComponent(gohelper.Type_RectTransform)

	local var_36_0 = GameUtil.getViewSize() / 2
	local var_36_1, var_36_2 = recthelper.uiPosToScreenPos2(arg_36_0.rectTrPassive)
	local var_36_3, var_36_4 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(var_36_1, var_36_2, arg_36_1, CameraMgr.instance:getUICamera(), nil, nil)
	local var_36_5 = var_36_0 + var_36_3 - var_0_0.LeftWidth - var_0_0.Interval
	local var_36_6 = recthelper.getWidth(arg_36_2)
	local var_36_7 = var_36_6 <= var_36_5

	arg_36_2.pivot = CommonBuffTipEnum.Pivot.Right

	local var_36_8 = var_36_3
	local var_36_9 = var_36_4

	if var_36_7 then
		var_36_8 = var_36_8 - var_0_0.LeftWidth - var_0_0.Interval
	else
		var_36_8 = var_36_8 + var_0_0.RightWidth + var_0_0.Interval + var_36_6
	end

	local var_36_10 = var_36_9 + var_0_0.TopHeight

	recthelper.setAnchor(arg_36_2, var_36_8, var_36_10)
end

function var_0_0._setScrollMaskVisible(arg_37_0)
	local var_37_0 = gohelper.findChild(arg_37_0._gopassiveskilltip, "mask/root")

	ZProj.UGUIHelper.RebuildLayout(var_37_0.transform)

	arg_37_0._couldScroll = recthelper.getHeight(arg_37_0._passiveskilltipcontent.transform) > recthelper.getHeight(arg_37_0._scrollview.transform)

	gohelper.setActive(arg_37_0._gomask1, arg_37_0._couldScroll and not (gohelper.getRemindFourNumberFloat(arg_37_0._scrollview.verticalNormalizedPosition) <= 0))

	arg_37_0._passiveskilltipmask.enabled = false
end

function var_0_0._getPassiveUnlock(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	if arg_38_1 == CharacterEnum.showAttributeOption.ShowMax then
		return true
	elseif arg_38_1 == CharacterEnum.showAttributeOption.ShowMin then
		return false
	elseif arg_38_4 then
		return CharacterModel.instance:isPassiveUnlockByHeroMo(arg_38_4, arg_38_3, arg_38_0._passiveSkillLevel)
	else
		return CharacterModel.instance:isPassiveUnlock(arg_38_2, arg_38_3)
	end
end

function var_0_0._getTargetRankByEffect(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = SkillConfig.instance:getheroranksCO(arg_39_1)

	for iter_39_0, iter_39_1 in pairs(var_39_0) do
		if CharacterModel.instance:getrankEffects(arg_39_1, iter_39_0)[2] == arg_39_2 then
			return iter_39_0 - 1
		end
	end

	return 0
end

function var_0_0.showDetail(arg_40_0, arg_40_1)
	arg_40_0._isOpenAttrDesc = not arg_40_0._isOpenAttrDesc

	gohelper.setActive(arg_40_0._godetailcontent, arg_40_0._isOpenAttrDesc)

	if not arg_40_0._isOpenAttrDesc then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_role_description)

	local var_40_0 = recthelper.rectToRelativeAnchorPos(arg_40_1.go.transform.position, arg_40_0._goattributetip.transform)

	if var_40_0.y < var_0_0.DetailClickMinPos then
		recthelper.setAnchorY(arg_40_0._godetailcontent.transform, var_0_0.DetailBottomPos)
	else
		recthelper.setAnchorY(arg_40_0._godetailcontent.transform, var_40_0.y + var_0_0.DetailOffset)
	end

	local var_40_1 = HeroConfig.instance:getHeroAttributeCO(arg_40_1.attributeId)

	arg_40_0._txtDetailItemName.text = var_40_1.name

	CharacterController.instance:SetAttriIcon(arg_40_0._txtDetailItemIcon, arg_40_1.icon, GameUtil.parseColor("#975129"))

	local var_40_2 = string.split(var_40_1.desc, "|")

	for iter_40_0, iter_40_1 in ipairs(var_40_2) do
		local var_40_3 = arg_40_0._detailDescTab[iter_40_0]

		if not var_40_3 then
			var_40_3 = gohelper.clone(arg_40_0._txtDetailItemDesc.gameObject, arg_40_0._goattributecontentitem, "descItem")

			gohelper.setActive(var_40_3, false)
			table.insert(arg_40_0._detailDescTab, var_40_3)
		end

		gohelper.setActive(var_40_3, true)

		var_40_3:GetComponent(gohelper.Type_TextMesh).text = iter_40_1
	end

	for iter_40_2 = #var_40_2 + 1, #arg_40_0._detailDescTab do
		gohelper.setActive(arg_40_0._detailDescTab[iter_40_2], false)
	end
end

function var_0_0.onClose(arg_41_0)
	for iter_41_0, iter_41_1 in pairs(arg_41_0._detailClickItems) do
		iter_41_1:RemoveClickListener()
	end
end

return var_0_0
