module("modules.logic.character.view.CharacterView", package.seeall)

local var_0_0 = class("CharacterView", BaseView)
local var_0_1 = 5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/bgcanvas/bg/#simage_bg")
	arg_1_0._simageplayerbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/bgcanvas/bg/#simage_playerbg")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "anim/#go_herocontainer/dynamiccontainer/#go_spine")
	arg_1_0._simagestatic = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/#go_herocontainer/staticcontainer/#simage_static")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/go_btns/#btn_close")
	arg_1_0._btnhome = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/go_btns/#btn_home")
	arg_1_0._btndata = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/go_btns/#btn_data")
	arg_1_0._godatareddot = gohelper.findChild(arg_1_0.viewGO, "anim/go_btns/#btn_data/#go_datareddot")
	arg_1_0._btnskin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/go_btns/#btn_skin")
	arg_1_0._btnfavor = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/go_btns/#btn_favor")
	arg_1_0._imagefavor = gohelper.findChildImage(arg_1_0.viewGO, "anim/go_btns/#btn_favor")
	arg_1_0._btnhelp = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/go_btns/#btn_help")
	arg_1_0._gorare = gohelper.findChild(arg_1_0.viewGO, "anim/info/#go_rare")
	arg_1_0._imagecareericon = gohelper.findChildImage(arg_1_0.viewGO, "anim/info/#image_careericon")
	arg_1_0._imagedmgtype = gohelper.findChildImage(arg_1_0.viewGO, "anim/info/#image_dmgtype")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_0.viewGO, "anim/info/#txt_namecn")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "anim/info/#txt_namecn/#txt_nameen")
	arg_1_0._txttrust = gohelper.findChildText(arg_1_0.viewGO, "anim/info/trust/#txt_trust")
	arg_1_0._slidertrust = gohelper.findChildSlider(arg_1_0.viewGO, "anim/info/trust/#slider_trust")
	arg_1_0._gocareer = gohelper.findChild(arg_1_0.viewGO, "anim/#go_career")
	arg_1_0._btnattribute = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/attribute/#btn_attribute")
	arg_1_0._goattributenode = gohelper.findChild(arg_1_0.viewGO, "anim/attribute")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0.viewGO, "anim/attribute/#go_attribute")
	arg_1_0._goattributetipsnode = gohelper.findChild(arg_1_0.viewGO, "anim/#go_attributetips")
	arg_1_0._animatorattributetipsnode = arg_1_0._goattributetipsnode:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goattributetips = gohelper.findChild(arg_1_0.viewGO, "anim/#go_attributetips/#go_attribute")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "anim/level/lvtxt/#txt_level")
	arg_1_0._txtlevelmax = gohelper.findChildText(arg_1_0.viewGO, "anim/level/lvtxt/#txt_level/#txt_levelmax")
	arg_1_0._btnlevel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/level/#btn_level")
	arg_1_0._gorankeyes = gohelper.findChild(arg_1_0.viewGO, "anim/rank/#go_rankeyes")
	arg_1_0._goranklights = gohelper.findChild(arg_1_0.viewGO, "anim/rank/#go_ranklights")
	arg_1_0._btnrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/rank/#btn_rank")
	arg_1_0._gorankreddot = gohelper.findChild(arg_1_0.viewGO, "anim/rank/#go_rankreddot")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "anim/layout/#go_skillLayout/#go_skill")
	arg_1_0._btnpassiveskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/passiveskill/#btn_passiveskill")
	arg_1_0._txtpassivename = gohelper.findChildText(arg_1_0.viewGO, "anim/passiveskill/bg/passiveskillimage/#txt_passivename")
	arg_1_0._gopassiveskills = gohelper.findChild(arg_1_0.viewGO, "anim/passiveskill/#go_passiveskills")
	arg_1_0._btnexskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/layout/rightbottom/exskill/#btn_exskill")
	arg_1_0._goexskills = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/exskill/#go_exskills")
	arg_1_0._goexskillreddot = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/exskill/#go_exskillreddot")
	arg_1_0._gotalent = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent")
	arg_1_0._txttalentcn = gohelper.findChildText(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/talentcn")
	arg_1_0._txttalenten = gohelper.findChildText(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/talentcn/talenten")
	arg_1_0._btntalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#btn_talent")
	arg_1_0._gotalents = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talents")
	arg_1_0._gotalentstyle = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentstyle")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentstyle/#image_icon")
	arg_1_0._txttalentvalue = gohelper.findChildText(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#txt_talentvalue")
	arg_1_0._gotalentlock = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentlock")
	arg_1_0._gotalentreddot = gohelper.findChild(arg_1_0.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentreddot")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "anim/bottom/#go_contentbg")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "anim/bottom/#txt_ana_cn")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "anim/bottom/#txt_ana_en")
	arg_1_0._godynamiccontainer = gohelper.findChild(arg_1_0.viewGO, "anim/#go_herocontainer/dynamiccontainer")
	arg_1_0._gostaticcontainer = gohelper.findChild(arg_1_0.viewGO, "anim/#go_herocontainer/staticcontainer")
	arg_1_0._goherocontainer = gohelper.findChild(arg_1_0.viewGO, "anim/#go_herocontainer")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/bottom/#simage_signature")
	arg_1_0._golevelimage = gohelper.findChild(arg_1_0.viewGO, "anim/level/levelimage")
	arg_1_0._golevelicon = gohelper.findChild(arg_1_0.viewGO, "anim/level/addicon")
	arg_1_0._golevelimagetrial = gohelper.findChild(arg_1_0.viewGO, "anim/level/#go_levelimagetrial")
	arg_1_0._gorankimage = gohelper.findChild(arg_1_0.viewGO, "anim/rank/rankimage")
	arg_1_0._gorankicon = gohelper.findChild(arg_1_0.viewGO, "anim/rank/addicon")
	arg_1_0._gorankimagetrial = gohelper.findChild(arg_1_0.viewGO, "anim/rank/#go_rankimagetrial")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnhome:AddClickListener(arg_2_0._btnhomeOnClick, arg_2_0)
	arg_2_0._btndata:AddClickListener(arg_2_0._btndataOnClick, arg_2_0)
	arg_2_0._btnskin:AddClickListener(arg_2_0._btnskinOnClick, arg_2_0)
	arg_2_0._btnfavor:AddClickListener(arg_2_0._btnfavorOnClick, arg_2_0)
	arg_2_0._btnhelp:AddClickListener(arg_2_0._btnhelpOnClick, arg_2_0)
	arg_2_0._btnattribute:AddClickListener(arg_2_0._btnattributeOnClick, arg_2_0)
	arg_2_0._btnlevel:AddClickListener(arg_2_0._btnlevelOnClick, arg_2_0)
	arg_2_0._btnrank:AddClickListener(arg_2_0._btnrankOnClick, arg_2_0)
	arg_2_0._btnpassiveskill:AddClickListener(arg_2_0._btnpassiveskillOnClick, arg_2_0)
	arg_2_0._btnexskill:AddClickListener(arg_2_0._btnexskillOnClick, arg_2_0)
	arg_2_0._btntalent:AddClickListener(arg_2_0._btntalentOnClick, arg_2_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, arg_2_0._onApplicationPause, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, arg_2_0._refreshAttributeTips, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onTalentStyleRead, arg_2_0._refreshTalentRed, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, arg_2_0._onRefreshStyleIcon, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.UseTalentTemplateReply, arg_2_0._onRefreshStyleIcon, arg_2_0)
	arg_2_0:addEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, arg_2_0._onRefreshStyleIcon, arg_2_0)
	arg_2_0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, arg_2_0._onRefreshDestiny, arg_2_0)
	arg_2_0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, arg_2_0._onRefreshDestiny, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onRefreshCharacterSkill, arg_2_0._refreshSkill, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnhome:RemoveClickListener()
	arg_3_0._btndata:RemoveClickListener()
	arg_3_0._btnskin:RemoveClickListener()
	arg_3_0._btnfavor:RemoveClickListener()
	arg_3_0._btnhelp:RemoveClickListener()
	arg_3_0._btnattribute:RemoveClickListener()
	arg_3_0._btnlevel:RemoveClickListener()
	arg_3_0._btnrank:RemoveClickListener()
	arg_3_0._btnpassiveskill:RemoveClickListener()
	arg_3_0._btnexskill:RemoveClickListener()
	arg_3_0._btntalent:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.onApplicationPause, arg_3_0._onApplicationPause, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, arg_3_0._refreshAttributeTips, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onTalentStyleRead, arg_3_0._refreshTalentRed, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, arg_3_0._onRefreshStyleIcon, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.UseTalentTemplateReply, arg_3_0._onRefreshStyleIcon, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, arg_3_0._markFavorSuccess, arg_3_0)
	arg_3_0:removeEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, arg_3_0._onRefreshStyleIcon, arg_3_0)
	arg_3_0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, arg_3_0._onRefreshDestiny, arg_3_0)
	arg_3_0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, arg_3_0._onRefreshDestiny, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onRefreshCharacterSkill, arg_3_0._refreshSkill, arg_3_0)
end

var_0_0.HpAttrId = 101
var_0_0.AttackAttrId = 102
var_0_0.DefenseAttrId = 103
var_0_0.MdefenseAttrId = 104
var_0_0.TechnicAttrId = 105
var_0_0.RankIconOffset = 51.38
var_0_0.AttrIconColor = GameUtil.parseColor("#9b795e")
var_0_0.AttrIdList = {
	CharacterEnum.AttrId.Hp,
	CharacterEnum.AttrId.Defense,
	CharacterEnum.AttrId.Technic,
	CharacterEnum.AttrId.Mdefense,
	CharacterEnum.AttrId.Attack
}

function var_0_0._editableInitView(arg_4_0)
	gohelper.addUIClickAudio(arg_4_0._btnlevel.gameObject, AudioEnum.UI.Play_Ui_Level_Unfold)
	gohelper.addUIClickAudio(arg_4_0._btndata.gameObject, AudioEnum.UI.UI_role_introduce_open)
	gohelper.addUIClickAudio(arg_4_0._btnskin.gameObject, AudioEnum.UI.UI_role_skin_open)
	gohelper.addUIClickAudio(arg_4_0._btnhelp.gameObject, AudioEnum.UI.UI_help_open)
	gohelper.addUIClickAudio(arg_4_0._btnclose.gameObject, AudioEnum.UI.UI_Rolesclose)
	gohelper.addUIClickAudio(arg_4_0._btnhome.gameObject, AudioEnum.UI.UI_Rolesclose)
	gohelper.addUIClickAudio(arg_4_0._btnattribute.gameObject, AudioEnum.UI.Play_ui_role_description)
	gohelper.addUIClickAudio(arg_4_0._btntalent.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(arg_4_0._btnrank.gameObject, AudioEnum.UI.play_ui_role_insight_open)
	gohelper.setActive(arg_4_0._btnskin.gameObject, CharacterEnum.SkinOpen)

	local var_4_0 = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character)

	gohelper.setActive(arg_4_0._btnhelp.gameObject, var_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getCommonViewBg("full/juese_bj"))
	arg_4_0._simageplayerbg:LoadImage(ResUrl.getCharacterIcon("guangyun"))

	arg_4_0._uiSpine = GuiModelAgent.Create(arg_4_0._gospine, true)

	arg_4_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, arg_4_0.viewName)

	arg_4_0._rareStars = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, 6 do
		arg_4_0._rareStars[iter_4_0] = gohelper.findChild(arg_4_0._gorare, "rare" .. iter_4_0)
	end

	arg_4_0._careerlabels = arg_4_0:getUserDataTb_()

	for iter_4_1 = 1, 3 do
		arg_4_0._careerlabels[iter_4_1] = gohelper.findChildText(arg_4_0._gocareer, "careerlabel" .. iter_4_1)
	end

	arg_4_0._attributevalues = {}
	arg_4_0._levelUpAttributeValues = {}

	for iter_4_2 = 1, var_0_1 do
		local var_4_1 = arg_4_0:getUserDataTb_()

		var_4_1.value = gohelper.findChildText(arg_4_0._goattribute, "attribute" .. tostring(iter_4_2) .. "/txt_attribute")
		var_4_1.name = gohelper.findChildText(arg_4_0._goattribute, "attribute" .. tostring(iter_4_2) .. "/name")
		var_4_1.icon = gohelper.findChildImage(arg_4_0._goattribute, "attribute" .. tostring(iter_4_2) .. "/icon")
		var_4_1.rate = gohelper.findChildImage(arg_4_0._goattribute, "attribute" .. tostring(iter_4_2) .. "/rate")

		gohelper.setActive(var_4_1.rate.gameObject, false)

		arg_4_0._attributevalues[iter_4_2] = var_4_1

		local var_4_2 = arg_4_0:getUserDataTb_()
		local var_4_3 = "attribute" .. tostring(iter_4_2)

		var_4_2.value = gohelper.findChildText(arg_4_0._goattributetips, var_4_3 .. "/txt_attribute")
		var_4_2.newValue = gohelper.findChildText(arg_4_0._goattributetips, var_4_3 .. "/txt_attribute/txt_attribute2")
		var_4_2.newValueArrow = gohelper.findChildImage(arg_4_0._goattributetips, var_4_3 .. "/txt_attribute/image_Arrow")
		var_4_2.name = gohelper.findChildText(arg_4_0._goattributetips, var_4_3 .. "/name")
		var_4_2.icon = gohelper.findChildImage(arg_4_0._goattributetips, var_4_3 .. "/icon")
		arg_4_0._levelUpAttributeValues[iter_4_2] = var_4_2
	end

	arg_4_0._ranklights = {}

	for iter_4_3 = 1, 3 do
		local var_4_4 = arg_4_0:getUserDataTb_()

		var_4_4.go = gohelper.findChild(arg_4_0._goranklights, "light" .. iter_4_3)
		var_4_4.lights = arg_4_0:getUserDataTb_()

		for iter_4_4 = 1, iter_4_3 do
			table.insert(var_4_4.lights, gohelper.findChild(var_4_4.go, "star" .. iter_4_4))
		end

		arg_4_0._ranklights[iter_4_3] = var_4_4
	end

	arg_4_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goskill, CharacterSkillContainer)
	arg_4_0._passiveskillitems = {}

	for iter_4_5 = 1, 3 do
		arg_4_0._passiveskillitems[iter_4_5] = arg_4_0:_findPassiveskillitems(iter_4_5)
	end

	arg_4_0._passiveskillitems[0] = arg_4_0:_findPassiveskillitems(4)
	arg_4_0._exskills = arg_4_0:getUserDataTb_()

	for iter_4_6 = 1, 5 do
		arg_4_0._exskills[iter_4_6] = gohelper.findChild(arg_4_0._goexskills, "exskill" .. tostring(iter_4_6))
	end

	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._goherocontainer)
	arg_4_0._signatureDrag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._simagesignature.gameObject)
	arg_4_0._trustclick = SLFramework.UGUI.UIClickListener.Get(arg_4_0._txttrust.gameObject)
	arg_4_0._careerclick = SLFramework.UGUI.UIClickListener.Get(arg_4_0._imagecareericon.gameObject)
	arg_4_0._signatureClick = SLFramework.UGUI.UIClickListener.Get(arg_4_0._simagesignature.gameObject)
	arg_4_0._enableSwitchDrawing = false
	arg_4_0._gopifu = gohelper.findChild(arg_4_0.viewGO, "anim/bottom/#pifu")

	gohelper.setActive(arg_4_0._gopifu, arg_4_0._enableSwitchDrawing)
	arg_4_0:_addListener()

	arg_4_0._originSpineRootPosX = recthelper.getAnchorX(arg_4_0._goherocontainer.transform)
	arg_4_0._animator = ZProj.ProjAnimatorPlayer.Get(arg_4_0.viewGO)
	arg_4_0._herocontainerCanvasGroup = arg_4_0._goherocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._hasMoveIcon = false

	gohelper.setActive(arg_4_0._goattributenode, true)
	arg_4_0._animatorattributetipsnode:Play("close", 0, 1)

	arg_4_0._talentRedType1 = gohelper.findChild(arg_4_0._gotalentreddot, "type1")
	arg_4_0._talentRedNew = gohelper.findChild(arg_4_0._gotalentreddot, "new")
end

function var_0_0._findPassiveskillitems(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getUserDataTb_()

	var_5_0.go = gohelper.findChild(arg_5_0._gopassiveskills, "passiveskill" .. arg_5_1)
	var_5_0.on = gohelper.findChild(var_5_0.go, "on")
	var_5_0.off = gohelper.findChild(var_5_0.go, "off")

	return var_5_0
end

function var_0_0._refreshHelp(arg_6_0)
	local var_6_0 = arg_6_0._heroMO and arg_6_0:isOwnHero()
	local var_6_1 = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character)

	gohelper.setActive(arg_6_0._btnhelp.gameObject, var_6_1 and var_6_0)
end

function var_0_0._takeoffAllTalentCube(arg_7_0)
	HeroRpc.instance:TakeoffAllTalentCubeRequest(arg_7_0._heroMO.heroId)
end

function var_0_0._addDrag(arg_8_0)
	if not arg_8_0._drag then
		return
	end

	arg_8_0._drag:AddDragBeginListener(arg_8_0._onDragBegin, arg_8_0)
	arg_8_0._drag:AddDragListener(arg_8_0._onDrag, arg_8_0)
	arg_8_0._drag:AddDragEndListener(arg_8_0._onDragEnd, arg_8_0)
	arg_8_0._signatureDrag:AddDragBeginListener(arg_8_0._onDragBegin, arg_8_0)
	arg_8_0._signatureDrag:AddDragListener(arg_8_0._onDrag, arg_8_0)
	arg_8_0._signatureDrag:AddDragEndListener(arg_8_0._onDragEnd, arg_8_0)
end

function var_0_0._addListener(arg_9_0)
	arg_9_0._trustclick:AddClickListener(arg_9_0._onOpenTrustTip, arg_9_0)
	arg_9_0._careerclick:AddClickListener(arg_9_0._onOpenCareerTip, arg_9_0)
	arg_9_0._signatureClick:AddClickListener(arg_9_0._switchDrawingOnClick, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.TakeoffAllTalentCube, arg_9_0._takeoffAllTalentCube, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_9_0._refreshView, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_9_0._refreshView, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_9_0._refreshView, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_9_0._refreshView, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_9_0._successDressUpSkin, arg_9_0)
	arg_9_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_9_0._refreshRedDot, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_9_0._onAttributeChanged, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_9_0._onAttributeChanged, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_9_0._showCharacterRankUpView, arg_9_0)
	arg_9_0:addEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, arg_9_0._markFavorSuccess, arg_9_0)
	arg_9_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_9_0._refreshHelp, arg_9_0)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_9_0._onOpenFullView, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_9_0._onOpenFullViewFinish, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_9_0._onOpenView, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_9_0._onOpenViewFinish, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_9_0._onCloseViewFinish, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_9_0._onCloseFullView, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_9_0._onCloseView, arg_9_0, LuaEventSystem.Low)
	arg_9_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_9_0.onEquipChange, arg_9_0)
	arg_9_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_9_0.onEquipChange, arg_9_0)
end

function var_0_0._markFavorSuccess(arg_10_0)
	arg_10_0._heroMO = HeroModel.instance:getByHeroId(arg_10_0._heroMO.heroId)

	arg_10_0:_refreshBtn()
end

function var_0_0._onApplicationPause(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0:_resetSpinePos(false)
	end
end

function var_0_0._setModelVisible(arg_12_0, arg_12_1)
	TaskDispatcher.cancelTask(arg_12_0._delaySetModelHide, arg_12_0)

	if arg_12_1 then
		arg_12_0._uiSpine:setLayer(UnityLayer.Unit)
		arg_12_0._uiSpine:setModelVisible(arg_12_1)
		arg_12_0._uiSpine:showModelEffect()
	else
		arg_12_0._uiSpine:setLayer(UnityLayer.Water)
		arg_12_0._uiSpine:hideModelEffect()
		TaskDispatcher.runDelay(arg_12_0._delaySetModelHide, arg_12_0, 1)
	end
end

function var_0_0._delaySetModelHide(arg_13_0)
	if arg_13_0._uiSpine then
		arg_13_0._uiSpine:setModelVisible(false)
	end
end

function var_0_0._showCharacterRankUpView(arg_14_0, arg_14_1)
	if not arg_14_0._uiSpine then
		return
	end

	arg_14_0:_setModelVisible(false)

	if arg_14_1 then
		arg_14_0:playCloseViewAnim(arg_14_1)
	end
end

function var_0_0._onOpenView(arg_15_0, arg_15_1)
	return
end

function var_0_0._onOpenViewFinish(arg_16_0, arg_16_1)
	if arg_16_1 == ViewName.CharacterRankUpResultView and arg_16_0._uiSpine then
		arg_16_0._uiSpine:hideModelEffect()
	end

	if arg_16_1 ~= ViewName.CharacterGetView then
		return
	end

	if arg_16_0._uiSpine then
		arg_16_0:_setModelVisible(false)
	end
end

function var_0_0._successDressUpSkin(arg_17_0)
	arg_17_0.needSwitchSkin = true
end

function var_0_0._onCloseView(arg_18_0, arg_18_1)
	if ViewHelper.instance:checkViewOnTheTop(arg_18_0.viewName) then
		arg_18_0:setShaderKeyWord()

		if arg_18_0.needSwitchSkin then
			arg_18_0:_refreshSkin()

			arg_18_0.needSwitchSkin = false
		end
	end

	if arg_18_1 == ViewName.CharacterLevelUpView then
		gohelper.setActive(arg_18_0._goattributenode, true)
		arg_18_0._animatorattributetipsnode:Play("close", 0, 0)
	end
end

function var_0_0._onCloseViewFinish(arg_19_0, arg_19_1)
	if ViewHelper.instance:checkViewOnTheTop(arg_19_0.viewName) then
		arg_19_0:setShaderKeyWord()
	end

	if arg_19_1 == ViewName.CharacterRankUpResultView and arg_19_0._uiSpine then
		arg_19_0._uiSpine:showModelEffect()
	end

	if arg_19_1 ~= ViewName.CharacterGetView then
		return
	end

	if not arg_19_0._uiSpine then
		return
	end

	arg_19_0:_setModelVisible(true)
end

function var_0_0._onOpenFullView(arg_20_0, arg_20_1)
	if not arg_20_0._uiSpine or arg_20_1 == ViewName.CharacterView then
		return
	end

	arg_20_0:_setModelVisible(false)
end

function var_0_0._onOpenFullViewFinish(arg_21_0, arg_21_1)
	if ViewMgr.instance:isOpen(ViewName.CharacterGetView) then
		return
	end

	if not arg_21_0._uiSpine or arg_21_1 == ViewName.CharacterView then
		return
	end

	if arg_21_1 ~= ViewName.CharacterView then
		arg_21_0._uiSpine:stopVoice()
	else
		return
	end

	arg_21_0:_setModelVisible(arg_21_0.viewContainer._isVisible)
end

function var_0_0._onCloseFullView(arg_22_0, arg_22_1)
	if arg_22_0._animator and arg_22_0:isEnterCharacterView() then
		arg_22_0:playAnim(UIAnimationName.Open)
		arg_22_0.viewContainer:getEquipView():playOpenAnim()
	end

	if ViewMgr.instance:isOpen(ViewName.CharacterGetView) then
		return
	end

	if not arg_22_0._uiSpine then
		return
	end

	arg_22_0:_setModelVisible(arg_22_0.viewContainer._isVisible)

	if arg_22_1 == ViewName.CharacterRankUpResultView then
		arg_22_0:_checkPlaySpecialBodyMotion()

		if arg_22_0._skillContainer then
			arg_22_0._skillContainer:checkShowReplaceBeforeSkillUI()
		end
	end

	arg_22_0:_checkGuide()
end

function var_0_0.isEnterCharacterView(arg_23_0)
	local var_23_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_23_0 = #var_23_0, 1, -1 do
		if ViewMgr.instance:getSetting(var_23_0[iter_23_0]).layer == ViewMgr.instance:getSetting(arg_23_0.viewName).layer then
			return var_23_0[iter_23_0] == arg_23_0.viewName
		end
	end

	return false
end

function var_0_0.onOpenFinish(arg_24_0)
	arg_24_0:_addDrag()

	arg_24_0._isOpenFinish = true

	if arg_24_0._spineLoadedFinish then
		arg_24_0:_onSpineLoaded()
	end

	if not GuideModel.instance:isGuideRunning(GuideEnum.VerticalDrawingSwitchingGuide) or not arg_24_0._showSwitchDrawingGuide then
		local var_24_0 = arg_24_0.viewContainer.helpShowView

		var_24_0:setHelpId(HelpEnum.HelpId.Character)
		var_24_0:setDelayTime(0.5)
		var_24_0:tryShowHelp()
	end
end

function var_0_0._onOpenTrustTip(arg_25_0)
	logNormal("打开信赖值tip, 达到下一百分比羁绊值需要 " .. arg_25_0.nextFaith .. " 的羁绊值")
end

function var_0_0._onOpenCareerTip(arg_26_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mission_switch)
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function var_0_0._closeLevelUpview(arg_27_0)
	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	end
end

function var_0_0._btncloseOnClick(arg_28_0)
	arg_28_0:_closeLevelUpview()
	arg_28_0:closeThis()
end

function var_0_0._btnhomeOnClick(arg_29_0)
	arg_29_0:_closeLevelUpview()
	NavigateButtonsView.homeClick()
end

function var_0_0._btndataOnClick(arg_30_0)
	arg_30_0:_closeLevelUpview()

	local function var_30_0()
		CharacterController.instance:openCharacterDataView(arg_30_0._heroMO.heroId)
	end

	arg_30_0:playCloseViewAnim(var_30_0)
end

function var_0_0._btnskinOnClick(arg_32_0)
	arg_32_0:_closeLevelUpview()

	if arg_32_0._uiSpine then
		arg_32_0:_setModelVisible(false)
	end

	local function var_32_0()
		CharacterController.instance:openCharacterSkinView(arg_32_0._heroMO)
	end

	arg_32_0:playCloseViewAnim(var_32_0)
end

function var_0_0._btnfavorOnClick(arg_34_0)
	local var_34_0 = not arg_34_0._heroMO.isFavor

	if var_34_0 and #HeroModel.instance:getAllFavorHeros() >= CommonConfig.instance:getConstNum(ConstEnum.MaxFavorHeroCount) then
		GameFacade.showToast(ToastEnum.OverFavorMaxCount)

		return
	end

	local var_34_1 = arg_34_0._heroMO.heroId

	HeroRpc.instance:setMarkHeroFavorRequest(var_34_1, var_34_0)
end

function var_0_0._btnhelpOnClick(arg_35_0)
	arg_35_0:_closeLevelUpview()
	HelpController.instance:showHelp(HelpEnum.HelpId.Character)
end

function var_0_0._btnattributeOnClick(arg_36_0)
	local var_36_0 = {}

	var_36_0.tag = "attribute"
	var_36_0.heroMo = arg_36_0._heroMO
	var_36_0.heroid = arg_36_0._heroMO.heroId
	var_36_0.equips = arg_36_0._heroMO.defaultEquipUid ~= "0" and {
		arg_36_0._heroMO.defaultEquipUid
	} or nil
	var_36_0.trialEquipMo = arg_36_0._heroMO.trialEquipMo

	CharacterController.instance:openCharacterTipView(var_36_0)
end

function var_0_0._btnlevelOnClick(arg_37_0)
	CharacterController.instance:openCharacterLevelUpView(arg_37_0._heroMO, ViewName.CharacterView)
	arg_37_0._animatorattributetipsnode:Play("open", 0, 0)
	gohelper.setActive(arg_37_0._goattributenode, false)
end

function var_0_0._btnrankOnClick(arg_38_0)
	if not arg_38_0._uiSpine then
		return
	end

	arg_38_0:_setModelVisible(false)

	local function var_38_0()
		CharacterController.instance:openCharacterRankUpView(arg_38_0._heroMO)
	end

	arg_38_0:playCloseViewAnim(var_38_0)
end

function var_0_0._btnpassiveskillOnClick(arg_40_0)
	local var_40_0 = {}

	var_40_0.tag = "passiveskill"
	var_40_0.heroid = arg_40_0._heroMO.heroId
	var_40_0.anchorParams = {
		Vector2.New(1, 0.5),
		Vector2.New(1, 0.5)
	}
	var_40_0.tipPos = Vector2.New(-292, -51.1)
	var_40_0.buffTipsX = -770
	var_40_0.heroMo = arg_40_0._heroMO

	CharacterController.instance:openCharacterTipView(var_40_0)
end

function var_0_0._btnexskillOnClick(arg_41_0)
	if arg_41_0._heroMO and arg_41_0._heroMO:isNoShowExSkill() then
		GameFacade.showToast(ToastEnum.TrialHeroClickExSkill)

		return
	end

	local function var_41_0()
		CharacterController.instance:openCharacterExSkillView({
			heroId = arg_41_0._heroMO.heroId,
			heroMo = arg_41_0._heroMO,
			fromHeroDetailView = arg_41_0._fromHeroDetailView,
			hideTrialTip = arg_41_0._hideTrialTip
		})
	end

	arg_41_0:playCloseViewAnim(var_41_0)
end

function var_0_0._btntalentOnClick(arg_43_0)
	local var_43_0 = arg_43_0._heroMO:isOtherPlayerHero()

	if var_43_0 and not arg_43_0._heroMO:getOtherPlayerIsOpenTalent() then
		GameFacade.showToast(ToastEnum.TalentNotUnlock)

		return
	end

	local var_43_1 = arg_43_0._heroMO:isTrial()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) or var_43_1 or var_43_0 then
		if arg_43_0._heroMO.rank < CharacterEnum.TalentRank then
			if arg_43_0._heroMO.config.heroType == CharacterEnum.HumanHeroType then
				GameFacade.showToast(ToastEnum.CharacterType6, arg_43_0._heroMO.config.name)
			else
				GameFacade.showToast(ToastEnum.Character, arg_43_0._heroMO.config.name)
			end

			return
		end

		local var_43_2 = arg_43_0:isOwnHero()

		if not var_43_2 then
			CharacterController.instance:openCharacterTalentTipView({
				open_type = 0,
				isTrial = true,
				hero_id = arg_43_0._heroMO.heroId,
				hero_mo = arg_43_0._heroMO,
				isOwnHero = var_43_2
			})

			return
		end

		CharacterController.instance:setTalentHeroId(arg_43_0._heroMO.heroId)

		local function var_43_3()
			CharacterController.instance:openCharacterTalentView({
				heroid = arg_43_0._heroMO.heroId,
				heroMo = arg_43_0._heroMO
			})
		end

		arg_43_0:playCloseViewAnim(var_43_3)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Talent))
	end
end

function var_0_0._switchDrawingOnClick(arg_45_0)
	if not arg_45_0._enableSwitchDrawing or arg_45_0._isDragingSpine then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_45_0 = SkinConfig.instance:getSkinCo(arg_45_0._heroMO.skin)
	local var_45_1 = CharacterDataConfig.instance:getCharacterDrawingState(var_45_0.characterId)

	if var_45_1 == CharacterEnum.DrawingState.Static then
		var_45_1 = CharacterEnum.DrawingState.Dynamic
	else
		var_45_1 = CharacterEnum.DrawingState.Static
	end

	CharacterDataConfig.instance:setCharacterDrawingState(var_45_0.characterId, var_45_1)
	arg_45_0:_refreshDrawingState()
end

function var_0_0._initExternalParams(arg_46_0)
	local var_46_0 = var_0_0._externalParam

	arg_46_0._hideHomeBtn = var_46_0 and var_46_0.hideHomeBtn
	arg_46_0._isOwnHero = var_46_0 and var_46_0.isOwnHero
	arg_46_0._fromHeroDetailView = var_46_0 and var_46_0.fromHeroDetailView
	arg_46_0._hideTrialTip = var_46_0 and var_46_0.hideTrialTip

	arg_46_0.viewContainer:setIsOwnHero(var_46_0)

	var_0_0._externalParam = nil
end

function var_0_0.onOpen(arg_47_0)
	arg_47_0:_initExternalParams()

	arg_47_0._heroMO = arg_47_0.viewParam
	arg_47_0._playGreetingVoices = true
	arg_47_0._spineNeedHide = true

	arg_47_0:_refreshView()
	NavigateMgr.instance:addEscape(ViewName.CharacterView, arg_47_0._btncloseOnClick, arg_47_0)
	arg_47_0:_checkGuide()

	if arg_47_0._skillContainer then
		arg_47_0._skillContainer:checkShowReplaceBeforeSkillUI()
	end
end

function var_0_0._refreshRedDot(arg_48_0)
	if not arg_48_0:isOwnHero() then
		gohelper.setActive(arg_48_0._goexskillreddot, false)
		gohelper.setActive(arg_48_0._gorankreddot, false)
		gohelper.setActive(arg_48_0._godatareddot, false)
		arg_48_0:_showRedDot(false)

		return
	end

	local var_48_0 = CharacterModel.instance:isHeroCouldExskillUp(arg_48_0._heroMO.heroId)

	gohelper.setActive(arg_48_0._goexskillreddot, var_48_0)

	local var_48_1 = CharacterModel.instance:isHeroCouldRankUp(arg_48_0._heroMO.heroId)

	gohelper.setActive(arg_48_0._gorankreddot, var_48_1)

	local var_48_2 = CharacterModel.instance:hasCultureRewardGet(arg_48_0._heroMO.heroId) or CharacterModel.instance:hasItemRewardGet(arg_48_0._heroMO.heroId)

	gohelper.setActive(arg_48_0._godatareddot, var_48_2)
	arg_48_0:_refreshTalentRed()
end

function var_0_0._showRedDot(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_1 then
		gohelper.setActive(arg_49_0._gotalentreddot, true)
		gohelper.setActive(arg_49_0._talentRedType1, arg_49_2 == 1)
		gohelper.setActive(arg_49_0._talentRedNew, arg_49_2 == 2)
	else
		gohelper.setActive(arg_49_0._gotalentreddot, false)
	end
end

function var_0_0._refreshTalentRed(arg_50_0)
	local var_50_0 = CharacterModel.instance:heroTalentRedPoint(arg_50_0._heroMO.heroId)
	local var_50_1 = arg_50_0._heroMO.isShowTalentStyleRed and 2 or var_50_0 and 1 or 0

	arg_50_0:_showRedDot(true, var_50_1)
end

function var_0_0._refreshView(arg_51_0)
	arg_51_0:_unmarkNew()
	arg_51_0:_refreshBtn()
	arg_51_0:_refreshSkill()
	arg_51_0:_refreshDrawingState()
	arg_51_0:_refreshSpine()
	arg_51_0:_refreshInfo()
	arg_51_0:_refreshCareer()
	arg_51_0:_refreshAttribute()
	arg_51_0:_refreshLevel()
	arg_51_0:_refreshRank()
	arg_51_0:_refreshPassiveSkill()
	arg_51_0:_refreshExSkill()
	arg_51_0:_refreshTalent()
	arg_51_0:_refreshSignature()
	arg_51_0:_refreshRedDot()
end

function var_0_0.isOwnHero(arg_52_0)
	if arg_52_0._isOwnHero ~= nil then
		return arg_52_0._isOwnHero
	end

	return arg_52_0._heroMO and arg_52_0._heroMO:isOwnHero()
end

function var_0_0._refreshBtn(arg_53_0)
	local var_53_0 = arg_53_0:isOwnHero()
	local var_53_1 = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character)

	gohelper.setActive(arg_53_0._btnhome.gameObject, not arg_53_0._hideHomeBtn)
	gohelper.setActive(arg_53_0._btnhelp.gameObject, var_53_1 and var_53_0)
	gohelper.setActive(arg_53_0._btnskin.gameObject, CharacterEnum.SkinOpen and var_53_0)
	gohelper.setActive(arg_53_0._btnfavor.gameObject, var_53_0)
	gohelper.setActive(arg_53_0._btndata.gameObject, var_53_0)
	gohelper.setActive(arg_53_0._btnlevel.gameObject, var_53_0)
	gohelper.setActive(arg_53_0._btnrank.gameObject, var_53_0)
	gohelper.setActive(arg_53_0._golevelimage, var_53_0)
	gohelper.setActive(arg_53_0._golevelicon.gameObject, var_53_0)
	gohelper.setActive(arg_53_0._gorankicon, var_53_0)
	gohelper.setActive(arg_53_0._gorankimage, var_53_0)
	gohelper.setActive(arg_53_0._golevelimagetrial, not var_53_0)
	gohelper.setActive(arg_53_0._gorankimagetrial, not var_53_0)

	if not var_53_0 and not arg_53_0._hasMoveIcon then
		recthelper.setAnchorX(arg_53_0._gorankeyes.transform, recthelper.getAnchorX(arg_53_0._gorankeyes.transform) + var_0_0.RankIconOffset)
		recthelper.setAnchorX(arg_53_0._goranklights.transform, recthelper.getAnchorX(arg_53_0._goranklights.transform) + var_0_0.RankIconOffset)

		arg_53_0._hasMoveIcon = true
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_53_0._imagefavor, arg_53_0._heroMO.isFavor and "btn_favor_light" or "btn_favor_dark")
end

function var_0_0._refreshSkin(arg_54_0)
	arg_54_0._spineNeedHide = true

	arg_54_0:_refreshDrawingState()
	arg_54_0:_refreshSpine()
end

function var_0_0._unmarkNew(arg_55_0)
	if arg_55_0._heroMO and arg_55_0._heroMO.isNew then
		HeroRpc.instance:sendUnMarkIsNewRequest(arg_55_0._heroMO.heroId)
	end
end

function var_0_0._onDragBegin(arg_56_0, arg_56_1, arg_56_2)
	arg_56_0._startPos = arg_56_2.position.x

	arg_56_0:playAnim(UIAnimationName.SwitchClose)

	arg_56_0._isDragingSpine = true

	if arg_56_0._uiSpine then
		arg_56_0._uiSpine:showDragEffect(false)
	end
end

function var_0_0._onDrag(arg_57_0, arg_57_1, arg_57_2)
	if not arg_57_0._isDragingSpine then
		return
	end

	local var_57_0 = arg_57_2.position.x
	local var_57_1 = 1
	local var_57_2 = recthelper.getAnchorX(arg_57_0._goherocontainer.transform) + arg_57_2.delta.x * var_57_1

	recthelper.setAnchorX(arg_57_0._goherocontainer.transform, var_57_2)

	local var_57_3 = 0.001

	arg_57_0._herocontainerCanvasGroup.alpha = 1 - Mathf.Abs(arg_57_0._startPos - var_57_0) * var_57_3
end

function var_0_0._onDragEnd(arg_58_0, arg_58_1, arg_58_2)
	if not arg_58_0._isDragingSpine then
		return
	end

	if arg_58_0._uiSpine then
		arg_58_0._uiSpine:showDragEffect(true)
	end

	local var_58_0 = arg_58_2.position.x
	local var_58_1 = false
	local var_58_2 = false

	if var_58_0 > arg_58_0._startPos and var_58_0 - arg_58_0._startPos >= 300 then
		local var_58_3 = CharacterBackpackCardListModel.instance:getLastCharacterCard(arg_58_0._heroMO.heroId)

		if var_58_3 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

			arg_58_0._heroMO = var_58_3
			arg_58_0.viewContainer.viewParam = arg_58_0._heroMO
			arg_58_0._playGreetingVoices = true
			arg_58_0._delayPlayVoiceTime = 0.3
			var_58_2 = true
			arg_58_0._spineNeedHide = true

			arg_58_0:_refreshView()

			if arg_58_0._skillContainer then
				arg_58_0._skillContainer:checkShowReplaceBeforeSkillUI()
			end

			CharacterController.instance:dispatchEvent(CharacterEvent.RefreshDefaultEquip, arg_58_0._heroMO)
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSpine, arg_58_0._heroMO)
		end
	elseif var_58_0 < arg_58_0._startPos and arg_58_0._startPos - var_58_0 >= 300 then
		local var_58_4 = CharacterBackpackCardListModel.instance:getNextCharacterCard(arg_58_0._heroMO.heroId)

		if var_58_4 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

			arg_58_0._heroMO = var_58_4
			arg_58_0.viewContainer.viewParam = arg_58_0._heroMO
			arg_58_0._playGreetingVoices = true
			arg_58_0._delayPlayVoiceTime = 0.3
			var_58_2 = true
			arg_58_0._spineNeedHide = true

			arg_58_0:_refreshView()

			if arg_58_0._skillContainer then
				arg_58_0._skillContainer:checkShowReplaceBeforeSkillUI()
			end

			CharacterController.instance:dispatchEvent(CharacterEvent.RefreshDefaultEquip, arg_58_0._heroMO)
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSpine, arg_58_0._heroMO)

			var_58_1 = true
		end
	end

	arg_58_0:_resetSpinePos(var_58_2, var_58_1)

	arg_58_0._isDragingSpine = false
end

function var_0_0._resetSpinePos(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = recthelper.getAnchorX(arg_59_0._goherocontainer.transform)
	local var_59_1 = -800
	local var_59_2 = 800
	local var_59_3 = var_59_0

	if arg_59_1 then
		local var_59_4 = arg_59_2 and var_59_1 or var_59_2

		recthelper.setAnchorX(arg_59_0._goherocontainer.transform, var_59_4)
	end

	ZProj.UGUIHelper.RebuildLayout(arg_59_0._goherocontainer.transform)

	local var_59_5 = 0.3
	local var_59_6 = 0.5
	local var_59_7 = arg_59_1 and var_59_6 or var_59_5

	if arg_59_0._dragTweenId then
		ZProj.TweenHelper.KillById(arg_59_0._dragTweenId)
	end

	arg_59_0._dragTweenId = ZProj.TweenHelper.DOAnchorPosX(arg_59_0._goherocontainer.transform, arg_59_0._originSpineRootPosX, var_59_7, nil, arg_59_0, nil, EaseType.OutQuart)

	arg_59_0:playAnim(UIAnimationName.SwitchOpen)
	arg_59_0.viewContainer:getEquipView():playOpenAnim()

	arg_59_0._herocontainerCanvasGroup.alpha = 1
end

function var_0_0._refreshSignature(arg_60_0)
	local var_60_0 = arg_60_0._heroMO.config

	arg_60_0._simagesignature:UnLoadImage()
	arg_60_0._simagesignature:LoadImage(ResUrl.getSignature(var_60_0.signature))
end

function var_0_0._refreshSpine(arg_61_0)
	if arg_61_0._uiSpine then
		TaskDispatcher.cancelTask(arg_61_0._playSpineVoice, arg_61_0)
		arg_61_0._uiSpine:onDestroy()
		arg_61_0._uiSpine:stopVoice()

		arg_61_0._uiSpine = nil
	end

	arg_61_0._uiSpine = GuiModelAgent.Create(arg_61_0._gospine, true)

	local var_61_0 = SkinConfig.instance:getSkinCo(arg_61_0._heroMO.skin)

	arg_61_0._uiSpine:setResPath(var_61_0, arg_61_0._onSpineLoaded, arg_61_0)

	local var_61_1 = SkinConfig.instance:getSkinOffset(var_61_0.characterViewOffset)

	recthelper.setAnchor(arg_61_0._gospine.transform, tonumber(var_61_1[1]), tonumber(var_61_1[2]))
	transformhelper.setLocalScale(arg_61_0._gospine.transform, tonumber(var_61_1[3]), tonumber(var_61_1[3]), tonumber(var_61_1[3]))

	local var_61_2 = SkinConfig.instance:getSkinOffset(var_61_0.haloOffset)
	local var_61_3 = tonumber(var_61_2[1])
	local var_61_4 = tonumber(var_61_2[2])
	local var_61_5 = tonumber(var_61_2[3])

	recthelper.setAnchor(arg_61_0._simageplayerbg.transform, var_61_3, var_61_4)
	transformhelper.setLocalScale(arg_61_0._simageplayerbg.transform, var_61_5, var_61_5, var_61_5)
end

function var_0_0._onSpineLoaded(arg_62_0)
	if arg_62_0._uiSpine then
		arg_62_0._uiSpine:initSkinDragEffect(arg_62_0._heroMO.skin)
	end

	arg_62_0._spineLoadedFinish = true

	if not arg_62_0._isOpenFinish then
		return
	end

	if not arg_62_0._playGreetingVoices then
		return
	end

	if not arg_62_0._uiSpine then
		return
	end

	if not arg_62_0._gospine.activeInHierarchy then
		return
	end

	arg_62_0._playGreetingVoices = nil

	local var_62_0 = arg_62_0._heroMO.heroId
	local var_62_1 = CharacterDataConfig.instance:getCharacterDrawingState(var_62_0)

	if ViewMgr.instance:isOpen(ViewName.CharacterRankUpView) then
		return
	end

	if var_62_1 == CharacterEnum.DrawingState.Dynamic then
		if arg_62_0:isOwnHero() then
			arg_62_0._greetingVoices = HeroModel.instance:getVoiceConfig(var_62_0, CharacterEnum.VoiceType.Greeting)
		else
			arg_62_0._greetingVoices = {}

			local var_62_2 = CharacterDataConfig.instance:getCharacterVoicesCo(var_62_0)

			if var_62_2 then
				for iter_62_0, iter_62_1 in pairs(var_62_2) do
					if iter_62_1.type == CharacterEnum.VoiceType.Greeting and CharacterDataConfig.instance:checkVoiceSkin(iter_62_1, arg_62_0._heroMO.skin) then
						table.insert(arg_62_0._greetingVoices, iter_62_1)
					end
				end
			end
		end

		if arg_62_0._greetingVoices and #arg_62_0._greetingVoices > 0 then
			arg_62_0._delayTime = arg_62_0._delayPlayVoiceTime or 0

			if arg_62_0._uiSpine:isLive2D() then
				arg_62_0._uiSpine:setLive2dCameraLoadFinishCallback(arg_62_0.onLive2dCameraLoadedCallback, arg_62_0)

				return
			end

			arg_62_0:_startDelayPlayVoice(arg_62_0._delayTime)

			arg_62_0._delayPlayVoiceTime = 0
		end
	end
end

function var_0_0.onLive2dCameraLoadedCallback(arg_63_0)
	arg_63_0._uiSpine:setLive2dCameraLoadFinishCallback(nil, nil)
	arg_63_0:_startDelayPlayVoice(arg_63_0._delayTime)
end

function var_0_0._startDelayPlayVoice(arg_64_0, arg_64_1)
	arg_64_1 = arg_64_1 or 0
	arg_64_0._repeatNum = math.max(arg_64_1 * 30, CharacterVoiceEnum.DelayFrame + 1)
	arg_64_0._repeatCount = 0

	TaskDispatcher.cancelTask(arg_64_0._playSpineVoice, arg_64_0)
	TaskDispatcher.runRepeat(arg_64_0._playSpineVoice, arg_64_0, 0, arg_64_0._repeatNum)
end

function var_0_0._playSpineVoice(arg_65_0)
	arg_65_0._repeatCount = arg_65_0._repeatCount + 1

	if arg_65_0._repeatCount < arg_65_0._repeatNum then
		return
	end

	if not arg_65_0._uiSpine then
		return
	end

	if arg_65_0:_checkPlaySpecialBodyMotion() then
		return
	end

	arg_65_0._uiSpine:playVoice(arg_65_0._greetingVoices[1], nil, arg_65_0._txtanacn, arg_65_0._txtanaen, arg_65_0._gocontentbg)
end

function var_0_0._refreshDrawingState(arg_66_0)
	local var_66_0 = false
	local var_66_1 = SkinConfig.instance:getSkinCo(arg_66_0._heroMO.skin)

	if var_66_1.showDrawingSwitch == 1 then
		arg_66_0._enableSwitchDrawing = true

		if CharacterDataConfig.instance:getCharacterDrawingState(var_66_1.characterId) == CharacterEnum.DrawingState.Static then
			var_66_0 = true
		end
	else
		arg_66_0._enableSwitchDrawing = false

		CharacterDataConfig.instance:setCharacterDrawingState(var_66_1.characterId, CharacterEnum.DrawingState.Dynamic)
	end

	if arg_66_0._heroMO.isSettingSkinOffset then
		var_66_0 = true
	end

	if arg_66_0._spineNeedHide and var_66_0 then
		gohelper.setActive(arg_66_0._godynamiccontainer, false)
	else
		gohelper.setActive(arg_66_0._godynamiccontainer, true)
	end

	arg_66_0._spineNeedHide = false

	local var_66_2 = var_66_0 and 0.01 or 1

	transformhelper.setLocalScale(arg_66_0._godynamiccontainer.transform, var_66_2, var_66_2, var_66_2)

	if not var_66_0 then
		arg_66_0._uiSpine:hideModelEffect()
		arg_66_0._uiSpine:showModelEffect()
	end

	gohelper.setActive(arg_66_0._gostaticcontainer, var_66_0)

	if var_66_0 then
		arg_66_0._playGreetingVoices = nil

		if arg_66_0._uiSpine then
			arg_66_0._uiSpine:stopVoice()
		end

		arg_66_0._simagestatic:LoadImage(ResUrl.getHeadIconImg(var_66_1.drawing), arg_66_0._loadedImage, arg_66_0)
	else
		arg_66_0._simagestatic:UnLoadImage()
		arg_66_0:_setModelVisible(true)
	end

	gohelper.setActive(arg_66_0._gopifu, arg_66_0._enableSwitchDrawing)
end

function var_0_0._checkGuide(arg_67_0)
	arg_67_0._showSwitchDrawingGuide = false

	if not arg_67_0._enableSwitchDrawing then
		return
	end

	if not arg_67_0.viewContainer._isVisible then
		return
	end

	local var_67_0 = false
	local var_67_1 = HeroModel.instance:getList()

	for iter_67_0, iter_67_1 in ipairs(var_67_1) do
		if iter_67_1.rank > 1 and iter_67_1.config.rare >= 3 then
			var_67_0 = true

			break
		end
	end

	if var_67_0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnGuideSwitchDrawing)
	end

	arg_67_0._showSwitchDrawingGuide = var_67_0
end

function var_0_0._loadedImage(arg_68_0)
	local var_68_0 = SkinConfig.instance:getSkinCo(arg_68_0._heroMO.skin)

	gohelper.onceAddComponent(arg_68_0._simagestatic.gameObject, gohelper.Type_Image):SetNativeSize()

	local var_68_1 = var_68_0.characterViewImgOffset

	if not string.nilorempty(var_68_1) then
		local var_68_2 = string.splitToNumber(var_68_1, "#")

		recthelper.setAnchor(arg_68_0._simagestatic.transform, tonumber(var_68_2[1]), tonumber(var_68_2[2]))
		transformhelper.setLocalScale(arg_68_0._simagestatic.transform, tonumber(var_68_2[3]), tonumber(var_68_2[3]), tonumber(var_68_2[3]))
	else
		recthelper.setAnchor(arg_68_0._simagestatic.transform, 0, 0)
		transformhelper.setLocalScale(arg_68_0._simagestatic.transform, 1, 1, 1)
	end
end

function var_0_0._refreshInfo(arg_69_0)
	for iter_69_0 = 1, 6 do
		gohelper.setActive(arg_69_0._rareStars[iter_69_0], iter_69_0 <= CharacterEnum.Star[arg_69_0._heroMO.config.rare])
	end

	UISpriteSetMgr.instance:setCharactergetSprite(arg_69_0._imagecareericon, "charactercareer" .. tostring(arg_69_0._heroMO.config.career))
	UISpriteSetMgr.instance:setCommonSprite(arg_69_0._imagedmgtype, "dmgtype" .. tostring(arg_69_0._heroMO.config.dmgType))

	local var_69_0 = arg_69_0:_getFaithPercent()

	arg_69_0._txttrust.text = var_69_0 * 100 .. "%"

	arg_69_0._slidertrust:SetValue(var_69_0)

	arg_69_0._txtnamecn.text = arg_69_0._heroMO:getHeroName()
	arg_69_0._txtnameen.text = arg_69_0._heroMO.config.nameEng
	arg_69_0._txttalentcn.text = luaLang("talent_character_talentcn" .. arg_69_0._heroMO:getTalentTxtByHeroType())
	arg_69_0._txttalenten.text = luaLang("talent_character_talenten" .. arg_69_0._heroMO:getTalentTxtByHeroType())
end

function var_0_0._getFaithPercent(arg_70_0)
	local var_70_0 = HeroConfig.instance:getFaithPercent(arg_70_0._heroMO.faith)

	arg_70_0.nextFaith = var_70_0[2]

	return var_70_0[1]
end

function var_0_0._refreshCareer(arg_71_0)
	local var_71_0 = arg_71_0._heroMO.config.battleTag
	local var_71_1 = {}

	if not string.nilorempty(var_71_0) then
		var_71_1 = string.split(var_71_0, "#")
	end

	for iter_71_0 = 1, 3 do
		if iter_71_0 <= #var_71_1 then
			arg_71_0._careerlabels[iter_71_0].text = HeroConfig.instance:getBattleTagConfigCO(var_71_1[iter_71_0]).tagName
		else
			arg_71_0._careerlabels[iter_71_0].text = ""
		end
	end
end

function var_0_0._onAttributeChanged(arg_72_0, arg_72_1, arg_72_2)
	if not arg_72_2 or arg_72_2 == arg_72_0._heroMO.heroId then
		arg_72_0:_refreshAttribute(arg_72_1)
	end
end

function var_0_0.onEquipChange(arg_73_0)
	if not arg_73_0.viewParam:hasDefaultEquip() then
		return
	end

	arg_73_0:_refreshAttribute()
end

function var_0_0._refreshAttribute(arg_74_0, arg_74_1)
	local var_74_0 = arg_74_0._heroMO
	local var_74_1 = var_74_0:getHeroBaseAttrDict(arg_74_1)
	local var_74_2 = HeroConfig.instance:talentGainTab2IDTab(var_74_0:getTalentGain(arg_74_1))
	local var_74_3 = var_74_0.destinyStoneMo
	local var_74_4 = var_74_3:getAddAttrValues()
	local var_74_5 = {}

	for iter_74_0, iter_74_1 in ipairs(var_0_0.AttrIdList) do
		var_74_5[iter_74_1] = 0
	end

	local var_74_6 = arg_74_0._heroMO:isOtherPlayerHero()
	local var_74_7 = arg_74_0._heroMO:hasDefaultEquip()

	if not var_74_6 and var_74_7 then
		local var_74_8 = arg_74_0._heroMO and arg_74_0._heroMO:getTrialEquipMo()

		var_74_8 = var_74_8 or EquipModel.instance:getEquip(arg_74_0._heroMO.defaultEquipUid)

		local var_74_9, var_74_10, var_74_11, var_74_12 = EquipConfig.instance:getEquipAddBaseAttr(var_74_8)

		var_74_5[CharacterEnum.AttrId.Attack] = var_74_10
		var_74_5[CharacterEnum.AttrId.Hp] = var_74_9
		var_74_5[CharacterEnum.AttrId.Defense] = var_74_11
		var_74_5[CharacterEnum.AttrId.Mdefense] = var_74_12

		local var_74_13 = EquipConfig.instance:getEquipBreakAddAttrValueDict(var_74_8.config, var_74_8.breakLv)

		for iter_74_2, iter_74_3 in ipairs(var_0_0.AttrIdList) do
			local var_74_14 = var_74_13[iter_74_3]

			if var_74_14 ~= 0 then
				var_74_5[iter_74_3] = var_74_5[iter_74_3] + math.floor(var_74_14 / 100 * var_74_1[iter_74_3])
			end
		end
	end

	for iter_74_4, iter_74_5 in ipairs(var_0_0.AttrIdList) do
		local var_74_15 = var_74_2[iter_74_5] and var_74_2[iter_74_5].value and math.floor(var_74_2[iter_74_5].value) or 0
		local var_74_16 = var_74_3 and var_74_3:getAddValueByAttrId(var_74_4, iter_74_5, var_74_0) or 0
		local var_74_17 = var_74_1[iter_74_5] + var_74_5[iter_74_5] + var_74_15 + var_74_16

		arg_74_0._attributevalues[iter_74_4].value.text = var_74_17

		local var_74_18 = HeroConfig.instance:getHeroAttributeCO(iter_74_5)

		arg_74_0._attributevalues[iter_74_4].name.text = var_74_18.name

		CharacterController.instance:SetAttriIcon(arg_74_0._attributevalues[iter_74_4].icon, iter_74_5, var_0_0.AttrIconColor)

		local var_74_19 = arg_74_0._levelUpAttributeValues[iter_74_4]

		var_74_19.value.text = var_74_17
		var_74_19.name.text = var_74_18.name

		CharacterController.instance:SetAttriIcon(var_74_19.icon, iter_74_5, var_0_0.AttrIconColor)
	end
end

function var_0_0._refreshAttributeTips(arg_75_0, arg_75_1)
	local var_75_0 = arg_75_0._heroMO
	local var_75_1 = var_75_0.level

	if not arg_75_1 or arg_75_1 < var_75_1 then
		for iter_75_0, iter_75_1 in ipairs(arg_75_0._levelUpAttributeValues) do
			iter_75_1.newValue.text = 0
		end

		return
	end

	local var_75_2 = arg_75_1 == var_75_1
	local var_75_3 = var_75_0:getHeroBaseAttrDict(arg_75_1)
	local var_75_4 = HeroConfig.instance:talentGainTab2IDTab(var_75_0:getTalentGain(arg_75_1))
	local var_75_5 = var_75_0.destinyStoneMo
	local var_75_6 = var_75_5:getAddAttrValues()
	local var_75_7 = {}

	for iter_75_2, iter_75_3 in ipairs(var_0_0.AttrIdList) do
		var_75_7[iter_75_3] = 0
	end

	if var_75_0:hasDefaultEquip() then
		local var_75_8 = EquipModel.instance:getEquip(var_75_0.defaultEquipUid)
		local var_75_9, var_75_10, var_75_11, var_75_12 = EquipConfig.instance:getEquipAddBaseAttr(var_75_8)

		var_75_7[CharacterEnum.AttrId.Attack] = var_75_10
		var_75_7[CharacterEnum.AttrId.Hp] = var_75_9
		var_75_7[CharacterEnum.AttrId.Defense] = var_75_11
		var_75_7[CharacterEnum.AttrId.Mdefense] = var_75_12

		local var_75_13 = EquipConfig.instance:getEquipBreakAddAttrValueDict(var_75_8.config, var_75_8.breakLv)

		for iter_75_4, iter_75_5 in ipairs(var_0_0.AttrIdList) do
			local var_75_14 = var_75_13[iter_75_5]

			if var_75_14 ~= 0 then
				var_75_7[iter_75_5] = var_75_7[iter_75_5] + math.floor(var_75_14 / 100 * var_75_3[iter_75_5])
			end
		end
	end

	for iter_75_6, iter_75_7 in ipairs(var_0_0.AttrIdList) do
		local var_75_15 = var_75_4[iter_75_7] and var_75_4[iter_75_7].value and math.floor(var_75_4[iter_75_7].value) or 0
		local var_75_16 = var_75_5 and var_75_5:getAddValueByAttrId(var_75_6, iter_75_7, var_75_0) or 0
		local var_75_17 = var_75_3[iter_75_7] + var_75_7[iter_75_7] + var_75_15 + var_75_16
		local var_75_18 = arg_75_0._levelUpAttributeValues[iter_75_6]
		local var_75_19 = var_75_18.newValue

		var_75_19.text = var_75_17

		local var_75_20 = var_75_2 and "#C7C3C0" or "#65B96F"

		var_75_19.color = GameUtil.parseColor(var_75_20)
		var_75_18.newValueArrow.color = GameUtil.parseColor(var_75_20)
	end
end

function var_0_0._refreshLevel(arg_76_0)
	local var_76_0 = HeroConfig.instance:getShowLevel(arg_76_0._heroMO.level)
	local var_76_1 = HeroConfig.instance:getShowLevel(CharacterModel.instance:getrankEffects(arg_76_0._heroMO.heroId, arg_76_0._heroMO.rank)[1])
	local var_76_2 = var_76_0 .. "/"

	if arg_76_0._heroMO:getIsBalance() then
		var_76_2 = string.format("<color=#81abe5>%s</color>/", var_76_0)
	end

	arg_76_0._txtlevel.text = var_76_2
	arg_76_0._txtlevelmax.text = var_76_1
end

function var_0_0._refreshRank(arg_77_0)
	local var_77_0 = arg_77_0._heroMO.config.rare
	local var_77_1 = arg_77_0._heroMO.rank
	local var_77_2 = HeroConfig.instance:getMaxRank(var_77_0)

	for iter_77_0 = 1, 3 do
		gohelper.setActive(arg_77_0._ranklights[iter_77_0].go, var_77_2 == iter_77_0)

		for iter_77_1 = 1, iter_77_0 do
			if iter_77_1 <= var_77_1 - 1 then
				SLFramework.UGUI.GuiHelper.SetColor(arg_77_0._ranklights[iter_77_0].lights[iter_77_1]:GetComponent("Image"), "#feb73b")
			else
				SLFramework.UGUI.GuiHelper.SetColor(arg_77_0._ranklights[iter_77_0].lights[iter_77_1]:GetComponent("Image"), "#737373")
			end
		end
	end
end

function var_0_0._refreshSkill(arg_78_0)
	arg_78_0._skillContainer:onUpdateMO(arg_78_0._heroMO.heroId, nil, arg_78_0._heroMO)
end

function var_0_0._onRefreshDestiny(arg_79_0, arg_79_1, arg_79_2)
	arg_79_0:_refreshSkill()
end

function var_0_0._refreshPassiveSkill(arg_80_0)
	local var_80_0 = arg_80_0._heroMO:getpassiveskillsCO()
	local var_80_1 = var_80_0[1].skillPassive
	local var_80_2 = lua_skill.configDict[var_80_1]

	if not var_80_2 then
		logError("找不到被动技能, skillId: " .. tostring(var_80_1))

		return
	end

	arg_80_0._txtpassivename.text = var_80_2.name

	for iter_80_0 = 1, #var_80_0 do
		local var_80_3 = CharacterModel.instance:isPassiveUnlockByHeroMo(arg_80_0._heroMO, iter_80_0)

		gohelper.setActive(arg_80_0._passiveskillitems[iter_80_0].on, var_80_3)
		gohelper.setActive(arg_80_0._passiveskillitems[iter_80_0].off, not var_80_3)
		gohelper.setActive(arg_80_0._passiveskillitems[iter_80_0].go, true)
	end

	for iter_80_1 = #var_80_0 + 1, #arg_80_0._passiveskillitems do
		gohelper.setActive(arg_80_0._passiveskillitems[iter_80_1].go, false)
	end

	if var_80_0[0] then
		gohelper.setActive(arg_80_0._passiveskillitems[0].on, true)
		gohelper.setActive(arg_80_0._passiveskillitems[0].off, false)
		gohelper.setActive(arg_80_0._passiveskillitems[0].go, true)
	else
		gohelper.setActive(arg_80_0._passiveskillitems[0].go, false)
	end
end

function var_0_0._refreshExSkill(arg_81_0)
	for iter_81_0 = 1, 5 do
		if iter_81_0 <= arg_81_0._heroMO.exSkillLevel then
			SLFramework.UGUI.GuiHelper.SetColor(arg_81_0._exskills[iter_81_0]:GetComponent("Image"), "#feb73b")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_81_0._exskills[iter_81_0]:GetComponent("Image"), "#737373")
		end
	end
end

function var_0_0._refreshTalent(arg_82_0)
	local var_82_0 = arg_82_0._heroMO:isOwnHero()
	local var_82_1 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Talent) or not var_82_0
	local var_82_2 = false
	local var_82_3 = arg_82_0._heroMO:isOtherPlayerHero()
	local var_82_4

	if var_82_3 then
		var_82_2 = arg_82_0._heroMO:getOtherPlayerIsOpenTalent()
	else
		var_82_2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) or arg_82_0._heroMO:isTrial()
	end

	gohelper.setActive(arg_82_0._gotalent, var_82_1)
	gohelper.setActive(arg_82_0._gotalentlock, not var_82_2)
	ZProj.UGUIHelper.SetGrayscale(arg_82_0._gotalents, not var_82_2)
	arg_82_0:_showTalentStyleBtn()

	arg_82_0._txttalentvalue.text = HeroResonanceConfig.instance:getTalentConfig(arg_82_0._heroMO.heroId, arg_82_0._heroMO.talent + 1) and arg_82_0._heroMO.talent or luaLang("character_max_overseas")
end

function var_0_0._showTalentStyleBtn(arg_83_0)
	local var_83_0 = arg_83_0._heroMO:isOwnHero()
	local var_83_1 = TalentStyleModel.instance:isUnlockStyleSystem(arg_83_0._heroMO.talent)

	if not var_83_0 and not var_83_1 and not var_83_1 then
		arg_83_0:_showTalentBtn()

		return
	end

	local var_83_2 = arg_83_0._heroMO:getHeroUseCubeStyleId()
	local var_83_3 = arg_83_0._heroMO.talentCubeInfos:getMainCubeMo()

	if var_83_2 == 0 or not var_83_3 then
		arg_83_0:_showTalentBtn()

		return
	end

	local var_83_4 = var_83_3.id
	local var_83_5 = HeroResonanceConfig.instance:getTalentStyle(var_83_4)
	local var_83_6 = var_83_5 and var_83_5[var_83_2]

	if var_83_6 then
		local var_83_7, var_83_8 = var_83_6:getStyleTagIcon()
		local var_83_9 = var_83_6._styleCo.color

		arg_83_0._imageicon.color = GameUtil.parseColor(var_83_9)

		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_83_0._imageicon, var_83_8)
		gohelper.setActive(arg_83_0._gotalentstyle, true)
		gohelper.setActive(arg_83_0._gotalents, false)
	else
		arg_83_0:_showTalentBtn()
	end
end

function var_0_0._showTalentBtn(arg_84_0)
	gohelper.setActive(arg_84_0._gotalentstyle, false)
	gohelper.setActive(arg_84_0._gotalents, true)
end

function var_0_0._onRefreshStyleIcon(arg_85_0)
	arg_85_0:_showTalentStyleBtn()
end

function var_0_0.onClose(arg_86_0)
	if arg_86_0._drag then
		arg_86_0._drag:RemoveDragBeginListener()
		arg_86_0._drag:RemoveDragEndListener()
		arg_86_0._drag:RemoveDragListener()
	end

	if arg_86_0._signatureDrag then
		arg_86_0._signatureDrag:RemoveDragBeginListener()
		arg_86_0._signatureDrag:RemoveDragEndListener()
		arg_86_0._signatureDrag:RemoveDragListener()
	end

	arg_86_0._trustclick:RemoveClickListener()
	arg_86_0._careerclick:RemoveClickListener()
	arg_86_0._signatureClick:RemoveClickListener()

	if arg_86_0._uiSpine then
		arg_86_0._uiSpine:stopVoice()
	end

	if arg_86_0._dragTweenId then
		ZProj.TweenHelper.KillById(arg_86_0._dragTweenId)

		arg_86_0._dragTweenId = nil
	end

	TaskDispatcher.cancelTask(arg_86_0._playSpineVoice, arg_86_0)
	TaskDispatcher.cancelTask(arg_86_0._delaySetModelHide, arg_86_0)
	arg_86_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_86_0._onCloseViewFinish, arg_86_0)
	arg_86_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_86_0._onCloseFullView, arg_86_0)
	arg_86_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_86_0._onCloseView, arg_86_0)

	if arg_86_0._skillContainer then
		arg_86_0._skillContainer:onFinishreplaceSkillAnim()
		arg_86_0._skillContainer:clearDelay()
	end
end

function var_0_0.onUpdateParam(arg_87_0)
	arg_87_0._playGreetingVoices = true

	arg_87_0:clear()
	arg_87_0:_refreshView()
end

function var_0_0.clear(arg_88_0)
	arg_88_0._simagestatic:UnLoadImage()
	arg_88_0._simagesignature:UnLoadImage()
end

function var_0_0.playCloseViewAnim(arg_89_0, arg_89_1)
	if arg_89_0._tempFunc then
		TaskDispatcher.cancelTask(arg_89_0._tempFunc, arg_89_0)
	end

	arg_89_0:playAnim(UIAnimationName.Close)

	arg_89_0._tempFunc = arg_89_1

	UIBlockMgr.instance:startBlock(arg_89_0.viewName .. "ViewCloseAnim")
	TaskDispatcher.runDelay(arg_89_0._closeAnimFinish, arg_89_0, 0.18)
end

function var_0_0._closeAnimFinish(arg_90_0)
	UIBlockMgr.instance:endBlock(arg_90_0.viewName .. "ViewCloseAnim")
	arg_90_0:_tempFunc()
end

function var_0_0.playAnim(arg_91_0, arg_91_1)
	arg_91_0._isAnim = true

	arg_91_0:setShaderKeyWord()
	arg_91_0._animator:Play(arg_91_1, arg_91_0.onAnimDone, arg_91_0)
end

function var_0_0.onAnimDone(arg_92_0)
	arg_92_0._isAnim = false

	arg_92_0:setShaderKeyWord()
end

function var_0_0.setShaderKeyWord(arg_93_0)
	if arg_93_0._isDragingSpine or arg_93_0._isAnim then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function var_0_0.onDestroyView(arg_94_0)
	if arg_94_0._uiSpine then
		arg_94_0._uiSpine:onDestroy()

		arg_94_0._uiSpine = nil
	end

	arg_94_0._simageplayerbg:UnLoadImage()
	arg_94_0._simagebg:UnLoadImage()
	arg_94_0:clear()
	TaskDispatcher.cancelTask(arg_94_0._closeAnimFinish, arg_94_0)
	TaskDispatcher.cancelTask(arg_94_0._delaySetModelHide, arg_94_0)
	TaskDispatcher.cancelTask(arg_94_0._playSpineVoice, arg_94_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

function var_0_0._checkPlaySpecialBodyMotion(arg_95_0)
	if not arg_95_0._heroMO:isOwnHero() then
		return
	end

	local var_95_0, var_95_1, var_95_2 = CharacterModel.instance:isCanPlayReplaceSkillAnim(arg_95_0._heroMO)

	if var_95_0 and var_95_2 and not string.nilorempty(var_95_2.specialLive2d) then
		local var_95_3 = string.split(var_95_2.specialLive2d, "#")

		if not string.nilorempty(var_95_3[3]) then
			local var_95_4 = "b_" .. var_95_3[3]
			local var_95_5 = var_95_3[4] and tonumber(var_95_3[4]) or 0

			local function var_95_6()
				if arg_95_0._uiSpine then
					arg_95_0._uiSpine:setActionEventCb(nil, arg_95_0)

					if arg_95_0._greetingVoices and #arg_95_0._greetingVoices > 0 then
						arg_95_0._uiSpine:playVoice(arg_95_0._greetingVoices[1], nil, arg_95_0._txtanacn, arg_95_0._txtanaen, arg_95_0._gocontentbg)
					end
				end
			end

			arg_95_0._uiSpine:playSpecialMotion(var_95_4, false, var_95_5)
			arg_95_0._uiSpine:setActionEventCb(var_95_6, arg_95_0)

			return true
		end
	end
end

return var_0_0
