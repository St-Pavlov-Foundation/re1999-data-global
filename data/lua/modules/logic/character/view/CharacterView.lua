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
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "anim/layout/#go_skill")
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

	arg_4_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal)

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
		local var_4_5 = arg_4_0:getUserDataTb_()

		var_4_5.go = gohelper.findChild(arg_4_0._gopassiveskills, "passiveskill" .. tostring(iter_4_5))
		var_4_5.on = gohelper.findChild(var_4_5.go, "on")
		var_4_5.off = gohelper.findChild(var_4_5.go, "off")
		arg_4_0._passiveskillitems[iter_4_5] = var_4_5
	end

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

function var_0_0._refreshHelp(arg_5_0)
	local var_5_0 = arg_5_0._heroMO and arg_5_0:isOwnHero()
	local var_5_1 = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character)

	gohelper.setActive(arg_5_0._btnhelp.gameObject, var_5_1 and var_5_0)
end

function var_0_0._takeoffAllTalentCube(arg_6_0)
	HeroRpc.instance:TakeoffAllTalentCubeRequest(arg_6_0._heroMO.heroId)
end

function var_0_0._addDrag(arg_7_0)
	if not arg_7_0._drag then
		return
	end

	arg_7_0._drag:AddDragBeginListener(arg_7_0._onDragBegin, arg_7_0)
	arg_7_0._drag:AddDragListener(arg_7_0._onDrag, arg_7_0)
	arg_7_0._drag:AddDragEndListener(arg_7_0._onDragEnd, arg_7_0)
	arg_7_0._signatureDrag:AddDragBeginListener(arg_7_0._onDragBegin, arg_7_0)
	arg_7_0._signatureDrag:AddDragListener(arg_7_0._onDrag, arg_7_0)
	arg_7_0._signatureDrag:AddDragEndListener(arg_7_0._onDragEnd, arg_7_0)
end

function var_0_0._addListener(arg_8_0)
	arg_8_0._trustclick:AddClickListener(arg_8_0._onOpenTrustTip, arg_8_0)
	arg_8_0._careerclick:AddClickListener(arg_8_0._onOpenCareerTip, arg_8_0)
	arg_8_0._signatureClick:AddClickListener(arg_8_0._switchDrawingOnClick, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.TakeoffAllTalentCube, arg_8_0._takeoffAllTalentCube, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_8_0._refreshView, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_8_0._refreshView, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_8_0._refreshView, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_8_0._refreshView, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_8_0._successDressUpSkin, arg_8_0)
	arg_8_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_8_0._refreshRedDot, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_8_0._onAttributeChanged, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_8_0._onAttributeChanged, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_8_0._showCharacterRankUpView, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, arg_8_0._markFavorSuccess, arg_8_0)
	arg_8_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_8_0._refreshHelp, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_8_0._onOpenFullView, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_8_0._onOpenFullViewFinish, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_8_0._onOpenView, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_8_0._onOpenViewFinish, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_8_0._onCloseViewFinish, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_8_0._onCloseFullView, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_8_0._onCloseView, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_8_0.onEquipChange, arg_8_0)
	arg_8_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_8_0.onEquipChange, arg_8_0)
end

function var_0_0._markFavorSuccess(arg_9_0)
	arg_9_0._heroMO = HeroModel.instance:getByHeroId(arg_9_0._heroMO.heroId)

	arg_9_0:_refreshBtn()
end

function var_0_0._onApplicationPause(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0:_resetSpinePos(false)
	end
end

function var_0_0._setModelVisible(arg_11_0, arg_11_1)
	TaskDispatcher.cancelTask(arg_11_0._delaySetModelHide, arg_11_0)

	if arg_11_1 then
		arg_11_0._uiSpine:setLayer(UnityLayer.Unit)
		arg_11_0._uiSpine:setModelVisible(arg_11_1)
		arg_11_0._uiSpine:showModelEffect()
	else
		arg_11_0._uiSpine:setLayer(UnityLayer.Water)
		arg_11_0._uiSpine:hideModelEffect()
		TaskDispatcher.runDelay(arg_11_0._delaySetModelHide, arg_11_0, 1)
	end
end

function var_0_0._delaySetModelHide(arg_12_0)
	if arg_12_0._uiSpine then
		arg_12_0._uiSpine:setModelVisible(false)
	end
end

function var_0_0._showCharacterRankUpView(arg_13_0, arg_13_1)
	if not arg_13_0._uiSpine then
		return
	end

	arg_13_0:_setModelVisible(false)

	if arg_13_1 then
		arg_13_0:playCloseViewAnim(arg_13_1)
	end
end

function var_0_0._onOpenView(arg_14_0, arg_14_1)
	return
end

function var_0_0._onOpenViewFinish(arg_15_0, arg_15_1)
	if arg_15_1 == ViewName.CharacterRankUpResultView and arg_15_0._uiSpine then
		arg_15_0._uiSpine:hideModelEffect()
	end

	if arg_15_1 ~= ViewName.CharacterGetView then
		return
	end

	if arg_15_0._uiSpine then
		arg_15_0:_setModelVisible(false)
	end
end

function var_0_0._successDressUpSkin(arg_16_0)
	arg_16_0.needSwitchSkin = true
end

function var_0_0._onCloseView(arg_17_0, arg_17_1)
	if ViewHelper.instance:checkViewOnTheTop(arg_17_0.viewName) then
		arg_17_0:setShaderKeyWord()

		if arg_17_0.needSwitchSkin then
			arg_17_0:_refreshSkin()

			arg_17_0.needSwitchSkin = false
		end
	end

	if arg_17_1 == ViewName.CharacterLevelUpView then
		gohelper.setActive(arg_17_0._goattributenode, true)
		arg_17_0._animatorattributetipsnode:Play("close", 0, 0)
	end
end

function var_0_0._onCloseViewFinish(arg_18_0, arg_18_1)
	if ViewHelper.instance:checkViewOnTheTop(arg_18_0.viewName) then
		arg_18_0:setShaderKeyWord()
	end

	if arg_18_1 == ViewName.CharacterRankUpResultView and arg_18_0._uiSpine then
		arg_18_0._uiSpine:showModelEffect()
	end

	if arg_18_1 ~= ViewName.CharacterGetView then
		return
	end

	if not arg_18_0._uiSpine then
		return
	end

	arg_18_0:_setModelVisible(true)
end

function var_0_0._onOpenFullView(arg_19_0, arg_19_1)
	if not arg_19_0._uiSpine or arg_19_1 == ViewName.CharacterView then
		return
	end

	arg_19_0:_setModelVisible(false)
end

function var_0_0._onOpenFullViewFinish(arg_20_0, arg_20_1)
	if ViewMgr.instance:isOpen(ViewName.CharacterGetView) then
		return
	end

	if not arg_20_0._uiSpine or arg_20_1 == ViewName.CharacterView then
		return
	end

	if arg_20_1 ~= ViewName.CharacterView then
		arg_20_0._uiSpine:stopVoice()
	else
		return
	end

	arg_20_0:_setModelVisible(arg_20_0.viewContainer._isVisible)
end

function var_0_0._onCloseFullView(arg_21_0, arg_21_1)
	if arg_21_0._animator and arg_21_0:isEnterCharacterView() then
		arg_21_0:playAnim(UIAnimationName.Open)
		arg_21_0.viewContainer:getEquipView():playOpenAnim()
	end

	if ViewMgr.instance:isOpen(ViewName.CharacterGetView) then
		return
	end

	if not arg_21_0._uiSpine then
		return
	end

	arg_21_0:_setModelVisible(arg_21_0.viewContainer._isVisible)
	arg_21_0:_checkGuide()
end

function var_0_0.isEnterCharacterView(arg_22_0)
	local var_22_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_22_0 = #var_22_0, 1, -1 do
		if ViewMgr.instance:getSetting(var_22_0[iter_22_0]).layer == ViewMgr.instance:getSetting(arg_22_0.viewName).layer then
			return var_22_0[iter_22_0] == arg_22_0.viewName
		end
	end

	return false
end

function var_0_0.onOpenFinish(arg_23_0)
	arg_23_0:_addDrag()

	arg_23_0._isOpenFinish = true

	if arg_23_0._spineLoadedFinish then
		arg_23_0:_onSpineLoaded()
	end

	if not GuideModel.instance:isGuideRunning(GuideEnum.VerticalDrawingSwitchingGuide) or not arg_23_0._showSwitchDrawingGuide then
		local var_23_0 = arg_23_0.viewContainer.helpShowView

		var_23_0:setHelpId(HelpEnum.HelpId.Character)
		var_23_0:setDelayTime(0.5)
		var_23_0:tryShowHelp()
	end
end

function var_0_0._onOpenTrustTip(arg_24_0)
	logNormal("打开信赖值tip, 达到下一百分比羁绊值需要 " .. arg_24_0.nextFaith .. " 的羁绊值")
end

function var_0_0._onOpenCareerTip(arg_25_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mission_switch)
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function var_0_0._closeLevelUpview(arg_26_0)
	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	end
end

function var_0_0._btncloseOnClick(arg_27_0)
	arg_27_0:_closeLevelUpview()
	arg_27_0:closeThis()
end

function var_0_0._btnhomeOnClick(arg_28_0)
	arg_28_0:_closeLevelUpview()
	NavigateButtonsView.homeClick()
end

function var_0_0._btndataOnClick(arg_29_0)
	arg_29_0:_closeLevelUpview()

	local function var_29_0()
		CharacterController.instance:openCharacterDataView(arg_29_0._heroMO.heroId)
	end

	arg_29_0:playCloseViewAnim(var_29_0)
end

function var_0_0._btnskinOnClick(arg_31_0)
	arg_31_0:_closeLevelUpview()

	if arg_31_0._uiSpine then
		arg_31_0:_setModelVisible(false)
	end

	local function var_31_0()
		CharacterController.instance:openCharacterSkinView(arg_31_0._heroMO)
	end

	arg_31_0:playCloseViewAnim(var_31_0)
end

function var_0_0._btnfavorOnClick(arg_33_0)
	local var_33_0 = not arg_33_0._heroMO.isFavor

	if var_33_0 and #HeroModel.instance:getAllFavorHeros() >= CommonConfig.instance:getConstNum(ConstEnum.MaxFavorHeroCount) then
		GameFacade.showToast(ToastEnum.OverFavorMaxCount)

		return
	end

	local var_33_1 = arg_33_0._heroMO.heroId

	HeroRpc.instance:setMarkHeroFavorRequest(var_33_1, var_33_0)
end

function var_0_0._btnhelpOnClick(arg_34_0)
	arg_34_0:_closeLevelUpview()
	HelpController.instance:showHelp(HelpEnum.HelpId.Character)
end

function var_0_0._btnattributeOnClick(arg_35_0)
	local var_35_0 = {}

	var_35_0.tag = "attribute"
	var_35_0.heroMo = arg_35_0._heroMO
	var_35_0.heroid = arg_35_0._heroMO.heroId
	var_35_0.equips = arg_35_0._heroMO.defaultEquipUid ~= "0" and {
		arg_35_0._heroMO.defaultEquipUid
	} or nil
	var_35_0.trialEquipMo = arg_35_0._heroMO.trialEquipMo

	CharacterController.instance:openCharacterTipView(var_35_0)
end

function var_0_0._btnlevelOnClick(arg_36_0)
	CharacterController.instance:openCharacterLevelUpView(arg_36_0._heroMO, ViewName.CharacterView)
	arg_36_0._animatorattributetipsnode:Play("open", 0, 0)
	gohelper.setActive(arg_36_0._goattributenode, false)
end

function var_0_0._btnrankOnClick(arg_37_0)
	if not arg_37_0._uiSpine then
		return
	end

	arg_37_0:_setModelVisible(false)

	local function var_37_0()
		CharacterController.instance:openCharacterRankUpView(arg_37_0._heroMO)
	end

	arg_37_0:playCloseViewAnim(var_37_0)
end

function var_0_0._btnpassiveskillOnClick(arg_39_0)
	local var_39_0 = {}

	var_39_0.tag = "passiveskill"
	var_39_0.heroid = arg_39_0._heroMO.heroId
	var_39_0.anchorParams = {
		Vector2.New(1, 0.5),
		Vector2.New(1, 0.5)
	}
	var_39_0.tipPos = Vector2.New(-292, -51.1)
	var_39_0.buffTipsX = -770
	var_39_0.heroMo = arg_39_0._heroMO

	CharacterController.instance:openCharacterTipView(var_39_0)
end

function var_0_0._btnexskillOnClick(arg_40_0)
	if arg_40_0._heroMO and arg_40_0._heroMO:isNoShowExSkill() then
		GameFacade.showToast(ToastEnum.TrialHeroClickExSkill)

		return
	end

	local function var_40_0()
		CharacterController.instance:openCharacterExSkillView({
			heroId = arg_40_0._heroMO.heroId,
			heroMo = arg_40_0._heroMO,
			fromHeroDetailView = arg_40_0._fromHeroDetailView,
			hideTrialTip = arg_40_0._hideTrialTip
		})
	end

	arg_40_0:playCloseViewAnim(var_40_0)
end

function var_0_0._btntalentOnClick(arg_42_0)
	local var_42_0 = arg_42_0._heroMO:isOtherPlayerHero()

	if var_42_0 and not arg_42_0._heroMO:getOtherPlayerIsOpenTalent() then
		GameFacade.showToast(ToastEnum.TalentNotUnlock)

		return
	end

	local var_42_1 = arg_42_0._heroMO:isTrial()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) or var_42_1 or var_42_0 then
		if arg_42_0._heroMO.rank < CharacterEnum.TalentRank then
			if arg_42_0._heroMO.config.heroType == CharacterEnum.HumanHeroType then
				GameFacade.showToast(ToastEnum.CharacterType6, arg_42_0._heroMO.config.name)
			else
				GameFacade.showToast(ToastEnum.Character, arg_42_0._heroMO.config.name)
			end

			return
		end

		local var_42_2 = arg_42_0:isOwnHero()

		if not var_42_2 then
			CharacterController.instance:openCharacterTalentTipView({
				open_type = 0,
				isTrial = true,
				hero_id = arg_42_0._heroMO.heroId,
				hero_mo = arg_42_0._heroMO,
				isOwnHero = var_42_2
			})

			return
		end

		CharacterController.instance:setTalentHeroId(arg_42_0._heroMO.heroId)

		local function var_42_3()
			CharacterController.instance:openCharacterTalentView({
				heroid = arg_42_0._heroMO.heroId,
				heroMo = arg_42_0._heroMO
			})
		end

		arg_42_0:playCloseViewAnim(var_42_3)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Talent))
	end
end

function var_0_0._switchDrawingOnClick(arg_44_0)
	if not arg_44_0._enableSwitchDrawing or arg_44_0._isDragingSpine then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_44_0 = SkinConfig.instance:getSkinCo(arg_44_0._heroMO.skin)
	local var_44_1 = CharacterDataConfig.instance:getCharacterDrawingState(var_44_0.characterId)

	if var_44_1 == CharacterEnum.DrawingState.Static then
		var_44_1 = CharacterEnum.DrawingState.Dynamic
	else
		var_44_1 = CharacterEnum.DrawingState.Static
	end

	CharacterDataConfig.instance:setCharacterDrawingState(var_44_0.characterId, var_44_1)
	arg_44_0:_refreshDrawingState()
end

function var_0_0._initExternalParams(arg_45_0)
	local var_45_0 = var_0_0._externalParam

	arg_45_0._hideHomeBtn = var_45_0 and var_45_0.hideHomeBtn
	arg_45_0._isOwnHero = var_45_0 and var_45_0.isOwnHero
	arg_45_0._fromHeroDetailView = var_45_0 and var_45_0.fromHeroDetailView
	arg_45_0._hideTrialTip = var_45_0 and var_45_0.hideTrialTip

	arg_45_0.viewContainer:setIsOwnHero(var_45_0)

	var_0_0._externalParam = nil
end

function var_0_0.onOpen(arg_46_0)
	arg_46_0:_initExternalParams()

	arg_46_0._heroMO = arg_46_0.viewParam
	arg_46_0._playGreetingVoices = true
	arg_46_0._spineNeedHide = true

	arg_46_0:_refreshView()
	NavigateMgr.instance:addEscape(ViewName.CharacterView, arg_46_0._btncloseOnClick, arg_46_0)
	arg_46_0:_checkGuide()
end

function var_0_0._refreshRedDot(arg_47_0)
	if not arg_47_0:isOwnHero() then
		gohelper.setActive(arg_47_0._goexskillreddot, false)
		gohelper.setActive(arg_47_0._gorankreddot, false)
		gohelper.setActive(arg_47_0._godatareddot, false)
		arg_47_0:_showRedDot(false)

		return
	end

	local var_47_0 = CharacterModel.instance:isHeroCouldExskillUp(arg_47_0._heroMO.heroId)

	gohelper.setActive(arg_47_0._goexskillreddot, var_47_0)

	local var_47_1 = CharacterModel.instance:isHeroCouldRankUp(arg_47_0._heroMO.heroId)

	gohelper.setActive(arg_47_0._gorankreddot, var_47_1)

	local var_47_2 = CharacterModel.instance:hasCultureRewardGet(arg_47_0._heroMO.heroId) or CharacterModel.instance:hasItemRewardGet(arg_47_0._heroMO.heroId)

	gohelper.setActive(arg_47_0._godatareddot, var_47_2)
	arg_47_0:_refreshTalentRed()
end

function var_0_0._showRedDot(arg_48_0, arg_48_1, arg_48_2)
	if arg_48_1 then
		gohelper.setActive(arg_48_0._gotalentreddot, true)
		gohelper.setActive(arg_48_0._talentRedType1, arg_48_2 == 1)
		gohelper.setActive(arg_48_0._talentRedNew, arg_48_2 == 2)
	else
		gohelper.setActive(arg_48_0._gotalentreddot, false)
	end
end

function var_0_0._refreshTalentRed(arg_49_0)
	local var_49_0 = CharacterModel.instance:heroTalentRedPoint(arg_49_0._heroMO.heroId)
	local var_49_1 = arg_49_0._heroMO.isShowTalentStyleRed and 2 or var_49_0 and 1 or 0

	arg_49_0:_showRedDot(true, var_49_1)
end

function var_0_0._refreshView(arg_50_0)
	arg_50_0:_unmarkNew()
	arg_50_0:_refreshBtn()
	arg_50_0:_refreshSkill()
	arg_50_0:_refreshDrawingState()
	arg_50_0:_refreshSpine()
	arg_50_0:_refreshInfo()
	arg_50_0:_refreshCareer()
	arg_50_0:_refreshAttribute()
	arg_50_0:_refreshLevel()
	arg_50_0:_refreshRank()
	arg_50_0:_refreshPassiveSkill()
	arg_50_0:_refreshExSkill()
	arg_50_0:_refreshTalent()
	arg_50_0:_refreshSignature()
	arg_50_0:_refreshRedDot()
end

function var_0_0.isOwnHero(arg_51_0)
	if arg_51_0._isOwnHero ~= nil then
		return arg_51_0._isOwnHero
	end

	return arg_51_0._heroMO and arg_51_0._heroMO:isOwnHero()
end

function var_0_0._refreshBtn(arg_52_0)
	local var_52_0 = arg_52_0:isOwnHero()
	local var_52_1 = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character)

	gohelper.setActive(arg_52_0._btnhome.gameObject, not arg_52_0._hideHomeBtn)
	gohelper.setActive(arg_52_0._btnhelp.gameObject, var_52_1 and var_52_0)
	gohelper.setActive(arg_52_0._btnskin.gameObject, CharacterEnum.SkinOpen and var_52_0)
	gohelper.setActive(arg_52_0._btnfavor.gameObject, var_52_0)
	gohelper.setActive(arg_52_0._btndata.gameObject, var_52_0)
	gohelper.setActive(arg_52_0._btnlevel.gameObject, var_52_0)
	gohelper.setActive(arg_52_0._btnrank.gameObject, var_52_0)
	gohelper.setActive(arg_52_0._golevelimage, var_52_0)
	gohelper.setActive(arg_52_0._golevelicon.gameObject, var_52_0)
	gohelper.setActive(arg_52_0._gorankicon, var_52_0)
	gohelper.setActive(arg_52_0._gorankimage, var_52_0)
	gohelper.setActive(arg_52_0._golevelimagetrial, not var_52_0)
	gohelper.setActive(arg_52_0._gorankimagetrial, not var_52_0)

	if not var_52_0 and not arg_52_0._hasMoveIcon then
		recthelper.setAnchorX(arg_52_0._gorankeyes.transform, recthelper.getAnchorX(arg_52_0._gorankeyes.transform) + var_0_0.RankIconOffset)
		recthelper.setAnchorX(arg_52_0._goranklights.transform, recthelper.getAnchorX(arg_52_0._goranklights.transform) + var_0_0.RankIconOffset)

		arg_52_0._hasMoveIcon = true
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_52_0._imagefavor, arg_52_0._heroMO.isFavor and "btn_favor_light" or "btn_favor_dark")
end

function var_0_0._refreshSkin(arg_53_0)
	arg_53_0._spineNeedHide = true

	arg_53_0:_refreshDrawingState()
	arg_53_0:_refreshSpine()
end

function var_0_0._unmarkNew(arg_54_0)
	if arg_54_0._heroMO and arg_54_0._heroMO.isNew then
		HeroRpc.instance:sendUnMarkIsNewRequest(arg_54_0._heroMO.heroId)
	end
end

function var_0_0._onDragBegin(arg_55_0, arg_55_1, arg_55_2)
	arg_55_0._startPos = arg_55_2.position.x

	arg_55_0:playAnim(UIAnimationName.SwitchClose)

	arg_55_0._isDragingSpine = true

	if arg_55_0._uiSpine then
		arg_55_0._uiSpine:showDragEffect(false)
	end
end

function var_0_0._onDrag(arg_56_0, arg_56_1, arg_56_2)
	if not arg_56_0._isDragingSpine then
		return
	end

	local var_56_0 = arg_56_2.position.x
	local var_56_1 = 1
	local var_56_2 = recthelper.getAnchorX(arg_56_0._goherocontainer.transform) + arg_56_2.delta.x * var_56_1

	recthelper.setAnchorX(arg_56_0._goherocontainer.transform, var_56_2)

	local var_56_3 = 0.001

	arg_56_0._herocontainerCanvasGroup.alpha = 1 - Mathf.Abs(arg_56_0._startPos - var_56_0) * var_56_3
end

function var_0_0._onDragEnd(arg_57_0, arg_57_1, arg_57_2)
	if not arg_57_0._isDragingSpine then
		return
	end

	if arg_57_0._uiSpine then
		arg_57_0._uiSpine:showDragEffect(true)
	end

	local var_57_0 = arg_57_2.position.x
	local var_57_1 = false
	local var_57_2 = false

	if var_57_0 > arg_57_0._startPos and var_57_0 - arg_57_0._startPos >= 300 then
		local var_57_3 = CharacterBackpackCardListModel.instance:getLastCharacterCard(arg_57_0._heroMO.heroId)

		if var_57_3 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

			arg_57_0._heroMO = var_57_3
			arg_57_0.viewContainer.viewParam = arg_57_0._heroMO
			arg_57_0._playGreetingVoices = true
			arg_57_0._delayPlayVoiceTime = 0.3
			var_57_2 = true
			arg_57_0._spineNeedHide = true

			arg_57_0:_refreshView()
			CharacterController.instance:dispatchEvent(CharacterEvent.RefreshDefaultEquip, arg_57_0._heroMO)
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSpine, arg_57_0._heroMO)
		end
	elseif var_57_0 < arg_57_0._startPos and arg_57_0._startPos - var_57_0 >= 300 then
		local var_57_4 = CharacterBackpackCardListModel.instance:getNextCharacterCard(arg_57_0._heroMO.heroId)

		if var_57_4 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

			arg_57_0._heroMO = var_57_4
			arg_57_0.viewContainer.viewParam = arg_57_0._heroMO
			arg_57_0._playGreetingVoices = true
			arg_57_0._delayPlayVoiceTime = 0.3
			var_57_2 = true
			arg_57_0._spineNeedHide = true

			arg_57_0:_refreshView()
			CharacterController.instance:dispatchEvent(CharacterEvent.RefreshDefaultEquip, arg_57_0._heroMO)
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSpine, arg_57_0._heroMO)

			var_57_1 = true
		end
	end

	arg_57_0:_resetSpinePos(var_57_2, var_57_1)

	arg_57_0._isDragingSpine = false
end

function var_0_0._resetSpinePos(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = recthelper.getAnchorX(arg_58_0._goherocontainer.transform)
	local var_58_1 = -800
	local var_58_2 = 800
	local var_58_3 = var_58_0

	if arg_58_1 then
		local var_58_4 = arg_58_2 and var_58_1 or var_58_2

		recthelper.setAnchorX(arg_58_0._goherocontainer.transform, var_58_4)
	end

	ZProj.UGUIHelper.RebuildLayout(arg_58_0._goherocontainer.transform)

	local var_58_5 = 0.3
	local var_58_6 = 0.5
	local var_58_7 = arg_58_1 and var_58_6 or var_58_5

	if arg_58_0._dragTweenId then
		ZProj.TweenHelper.KillById(arg_58_0._dragTweenId)
	end

	arg_58_0._dragTweenId = ZProj.TweenHelper.DOAnchorPosX(arg_58_0._goherocontainer.transform, arg_58_0._originSpineRootPosX, var_58_7, nil, arg_58_0, nil, EaseType.OutQuart)

	arg_58_0:playAnim(UIAnimationName.SwitchOpen)
	arg_58_0.viewContainer:getEquipView():playOpenAnim()

	arg_58_0._herocontainerCanvasGroup.alpha = 1
end

function var_0_0._refreshSignature(arg_59_0)
	local var_59_0 = arg_59_0._heroMO.config

	arg_59_0._simagesignature:UnLoadImage()
	arg_59_0._simagesignature:LoadImage(ResUrl.getSignature(var_59_0.signature))
end

function var_0_0._refreshSpine(arg_60_0)
	if arg_60_0._uiSpine then
		TaskDispatcher.cancelTask(arg_60_0._playSpineVoice, arg_60_0)
		arg_60_0._uiSpine:onDestroy()
		arg_60_0._uiSpine:stopVoice()

		arg_60_0._uiSpine = nil
	end

	arg_60_0._uiSpine = GuiModelAgent.Create(arg_60_0._gospine, true)

	local var_60_0 = SkinConfig.instance:getSkinCo(arg_60_0._heroMO.skin)

	arg_60_0._uiSpine:setResPath(var_60_0, arg_60_0._onSpineLoaded, arg_60_0)

	local var_60_1 = SkinConfig.instance:getSkinOffset(var_60_0.characterViewOffset)

	recthelper.setAnchor(arg_60_0._gospine.transform, tonumber(var_60_1[1]), tonumber(var_60_1[2]))
	transformhelper.setLocalScale(arg_60_0._gospine.transform, tonumber(var_60_1[3]), tonumber(var_60_1[3]), tonumber(var_60_1[3]))

	local var_60_2 = SkinConfig.instance:getSkinOffset(var_60_0.haloOffset)
	local var_60_3 = tonumber(var_60_2[1])
	local var_60_4 = tonumber(var_60_2[2])
	local var_60_5 = tonumber(var_60_2[3])

	recthelper.setAnchor(arg_60_0._simageplayerbg.transform, var_60_3, var_60_4)
	transformhelper.setLocalScale(arg_60_0._simageplayerbg.transform, var_60_5, var_60_5, var_60_5)
end

function var_0_0._onSpineLoaded(arg_61_0)
	if arg_61_0._uiSpine then
		arg_61_0._uiSpine:initSkinDragEffect(arg_61_0._heroMO.skin)
	end

	arg_61_0._spineLoadedFinish = true

	if not arg_61_0._isOpenFinish then
		return
	end

	if not arg_61_0._playGreetingVoices then
		return
	end

	if not arg_61_0._uiSpine then
		return
	end

	if not arg_61_0._gospine.activeInHierarchy then
		return
	end

	arg_61_0._playGreetingVoices = nil

	local var_61_0 = arg_61_0._heroMO.heroId
	local var_61_1 = CharacterDataConfig.instance:getCharacterDrawingState(var_61_0)

	if ViewMgr.instance:isOpen(ViewName.CharacterRankUpView) then
		return
	end

	if var_61_1 == CharacterEnum.DrawingState.Dynamic then
		if arg_61_0:isOwnHero() then
			arg_61_0._greetingVoices = HeroModel.instance:getVoiceConfig(var_61_0, CharacterEnum.VoiceType.Greeting)
		else
			arg_61_0._greetingVoices = {}

			local var_61_2 = CharacterDataConfig.instance:getCharacterVoicesCo(var_61_0)

			if var_61_2 then
				for iter_61_0, iter_61_1 in pairs(var_61_2) do
					if iter_61_1.type == CharacterEnum.VoiceType.Greeting and CharacterDataConfig.instance:checkVoiceSkin(iter_61_1, arg_61_0._heroMO.skin) then
						table.insert(arg_61_0._greetingVoices, iter_61_1)
					end
				end
			end
		end

		if arg_61_0._greetingVoices and #arg_61_0._greetingVoices > 0 then
			arg_61_0._delayTime = arg_61_0._delayPlayVoiceTime or 0

			if arg_61_0._uiSpine:isLive2D() then
				arg_61_0._uiSpine:setLive2dCameraLoadFinishCallback(arg_61_0.onLive2dCameraLoadedCallback, arg_61_0)

				return
			end

			arg_61_0:_startDelayPlayVoice(arg_61_0._delayTime)

			arg_61_0._delayPlayVoiceTime = 0
		end
	end
end

function var_0_0.onLive2dCameraLoadedCallback(arg_62_0)
	arg_62_0._uiSpine:setLive2dCameraLoadFinishCallback(nil, nil)
	arg_62_0:_startDelayPlayVoice(arg_62_0._delayTime)
end

function var_0_0._startDelayPlayVoice(arg_63_0, arg_63_1)
	arg_63_1 = arg_63_1 or 0
	arg_63_0._repeatNum = math.max(arg_63_1 * 30, CharacterVoiceEnum.DelayFrame + 1)
	arg_63_0._repeatCount = 0

	TaskDispatcher.cancelTask(arg_63_0._playSpineVoice, arg_63_0)
	TaskDispatcher.runRepeat(arg_63_0._playSpineVoice, arg_63_0, 0, arg_63_0._repeatNum)
end

function var_0_0._playSpineVoice(arg_64_0)
	arg_64_0._repeatCount = arg_64_0._repeatCount + 1

	if arg_64_0._repeatCount < arg_64_0._repeatNum then
		return
	end

	if not arg_64_0._uiSpine then
		return
	end

	arg_64_0._uiSpine:playVoice(arg_64_0._greetingVoices[1], nil, arg_64_0._txtanacn, arg_64_0._txtanaen, arg_64_0._gocontentbg)
end

function var_0_0._refreshDrawingState(arg_65_0)
	local var_65_0 = false
	local var_65_1 = SkinConfig.instance:getSkinCo(arg_65_0._heroMO.skin)

	if var_65_1.showDrawingSwitch == 1 then
		arg_65_0._enableSwitchDrawing = true

		if CharacterDataConfig.instance:getCharacterDrawingState(var_65_1.characterId) == CharacterEnum.DrawingState.Static then
			var_65_0 = true
		end
	else
		arg_65_0._enableSwitchDrawing = false

		CharacterDataConfig.instance:setCharacterDrawingState(var_65_1.characterId, CharacterEnum.DrawingState.Dynamic)
	end

	if arg_65_0._heroMO.isSettingSkinOffset then
		var_65_0 = true
	end

	if arg_65_0._spineNeedHide and var_65_0 then
		gohelper.setActive(arg_65_0._godynamiccontainer, false)
	else
		gohelper.setActive(arg_65_0._godynamiccontainer, true)
	end

	arg_65_0._spineNeedHide = false

	local var_65_2 = var_65_0 and 0.01 or 1

	transformhelper.setLocalScale(arg_65_0._godynamiccontainer.transform, var_65_2, var_65_2, var_65_2)

	if not var_65_0 then
		arg_65_0._uiSpine:hideModelEffect()
		arg_65_0._uiSpine:showModelEffect()
	end

	gohelper.setActive(arg_65_0._gostaticcontainer, var_65_0)

	if var_65_0 then
		arg_65_0._playGreetingVoices = nil

		if arg_65_0._uiSpine then
			arg_65_0._uiSpine:stopVoice()
		end

		arg_65_0._simagestatic:LoadImage(ResUrl.getHeadIconImg(var_65_1.drawing), arg_65_0._loadedImage, arg_65_0)
	else
		arg_65_0._simagestatic:UnLoadImage()
		arg_65_0:_setModelVisible(true)
	end

	gohelper.setActive(arg_65_0._gopifu, arg_65_0._enableSwitchDrawing)
end

function var_0_0._checkGuide(arg_66_0)
	arg_66_0._showSwitchDrawingGuide = false

	if not arg_66_0._enableSwitchDrawing then
		return
	end

	if not arg_66_0.viewContainer._isVisible then
		return
	end

	local var_66_0 = false
	local var_66_1 = HeroModel.instance:getList()

	for iter_66_0, iter_66_1 in ipairs(var_66_1) do
		if iter_66_1.rank > 1 and iter_66_1.config.rare >= 3 then
			var_66_0 = true

			break
		end
	end

	if var_66_0 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnGuideSwitchDrawing)
	end

	arg_66_0._showSwitchDrawingGuide = var_66_0
end

function var_0_0._loadedImage(arg_67_0)
	local var_67_0 = SkinConfig.instance:getSkinCo(arg_67_0._heroMO.skin)

	gohelper.onceAddComponent(arg_67_0._simagestatic.gameObject, gohelper.Type_Image):SetNativeSize()

	local var_67_1 = var_67_0.characterViewImgOffset

	if not string.nilorempty(var_67_1) then
		local var_67_2 = string.splitToNumber(var_67_1, "#")

		recthelper.setAnchor(arg_67_0._simagestatic.transform, tonumber(var_67_2[1]), tonumber(var_67_2[2]))
		transformhelper.setLocalScale(arg_67_0._simagestatic.transform, tonumber(var_67_2[3]), tonumber(var_67_2[3]), tonumber(var_67_2[3]))
	else
		recthelper.setAnchor(arg_67_0._simagestatic.transform, 0, 0)
		transformhelper.setLocalScale(arg_67_0._simagestatic.transform, 1, 1, 1)
	end
end

function var_0_0._refreshInfo(arg_68_0)
	for iter_68_0 = 1, 6 do
		gohelper.setActive(arg_68_0._rareStars[iter_68_0], iter_68_0 <= CharacterEnum.Star[arg_68_0._heroMO.config.rare])
	end

	UISpriteSetMgr.instance:setCharactergetSprite(arg_68_0._imagecareericon, "charactercareer" .. tostring(arg_68_0._heroMO.config.career))
	UISpriteSetMgr.instance:setCommonSprite(arg_68_0._imagedmgtype, "dmgtype" .. tostring(arg_68_0._heroMO.config.dmgType))

	local var_68_0 = arg_68_0:_getFaithPercent()

	arg_68_0._txttrust.text = var_68_0 * 100 .. "%"

	arg_68_0._slidertrust:SetValue(var_68_0)

	arg_68_0._txtnamecn.text = arg_68_0._heroMO:getHeroName()
	arg_68_0._txtnameen.text = arg_68_0._heroMO.config.nameEng
	arg_68_0._txttalentcn.text = luaLang("talent_character_talentcn" .. CharacterEnum.TalentTxtByHeroType[arg_68_0._heroMO.config.heroType])
	arg_68_0._txttalenten.text = luaLang("talent_character_talenten" .. CharacterEnum.TalentTxtByHeroType[arg_68_0._heroMO.config.heroType])
end

function var_0_0._getFaithPercent(arg_69_0)
	local var_69_0 = HeroConfig.instance:getFaithPercent(arg_69_0._heroMO.faith)

	arg_69_0.nextFaith = var_69_0[2]

	return var_69_0[1]
end

function var_0_0._refreshCareer(arg_70_0)
	local var_70_0 = arg_70_0._heroMO.config.battleTag
	local var_70_1 = {}

	if not string.nilorempty(var_70_0) then
		var_70_1 = string.split(var_70_0, "#")
	end

	for iter_70_0 = 1, 3 do
		if iter_70_0 <= #var_70_1 then
			arg_70_0._careerlabels[iter_70_0].text = HeroConfig.instance:getBattleTagConfigCO(var_70_1[iter_70_0]).tagName
		else
			arg_70_0._careerlabels[iter_70_0].text = ""
		end
	end
end

function var_0_0._onAttributeChanged(arg_71_0, arg_71_1, arg_71_2)
	if not arg_71_2 or arg_71_2 == arg_71_0._heroMO.heroId then
		arg_71_0:_refreshAttribute(arg_71_1)
	end
end

function var_0_0.onEquipChange(arg_72_0)
	if not arg_72_0.viewParam:hasDefaultEquip() then
		return
	end

	arg_72_0:_refreshAttribute()
end

function var_0_0._refreshAttribute(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_0._heroMO
	local var_73_1 = var_73_0:getHeroBaseAttrDict(arg_73_1)
	local var_73_2 = HeroConfig.instance:talentGainTab2IDTab(var_73_0:getTalentGain(arg_73_1))
	local var_73_3 = var_73_0.destinyStoneMo
	local var_73_4 = var_73_3:getAddAttrValues()
	local var_73_5 = {}

	for iter_73_0, iter_73_1 in ipairs(var_0_0.AttrIdList) do
		var_73_5[iter_73_1] = 0
	end

	local var_73_6 = arg_73_0._heroMO:isOtherPlayerHero()
	local var_73_7 = arg_73_0._heroMO:hasDefaultEquip()

	if not var_73_6 and var_73_7 then
		local var_73_8 = arg_73_0._heroMO and arg_73_0._heroMO:getTrialEquipMo()

		var_73_8 = var_73_8 or EquipModel.instance:getEquip(arg_73_0._heroMO.defaultEquipUid)

		local var_73_9, var_73_10, var_73_11, var_73_12 = EquipConfig.instance:getEquipAddBaseAttr(var_73_8)

		var_73_5[CharacterEnum.AttrId.Attack] = var_73_10
		var_73_5[CharacterEnum.AttrId.Hp] = var_73_9
		var_73_5[CharacterEnum.AttrId.Defense] = var_73_11
		var_73_5[CharacterEnum.AttrId.Mdefense] = var_73_12

		local var_73_13 = EquipConfig.instance:getEquipBreakAddAttrValueDict(var_73_8.config, var_73_8.breakLv)

		for iter_73_2, iter_73_3 in ipairs(var_0_0.AttrIdList) do
			local var_73_14 = var_73_13[iter_73_3]

			if var_73_14 ~= 0 then
				var_73_5[iter_73_3] = var_73_5[iter_73_3] + math.floor(var_73_14 / 100 * var_73_1[iter_73_3])
			end
		end
	end

	for iter_73_4, iter_73_5 in ipairs(var_0_0.AttrIdList) do
		local var_73_15 = var_73_2[iter_73_5] and var_73_2[iter_73_5].value and math.floor(var_73_2[iter_73_5].value) or 0
		local var_73_16 = var_73_3 and var_73_3:getAddValueByAttrId(var_73_4, iter_73_5, var_73_0) or 0
		local var_73_17 = var_73_1[iter_73_5] + var_73_5[iter_73_5] + var_73_15 + var_73_16

		arg_73_0._attributevalues[iter_73_4].value.text = var_73_17

		local var_73_18 = HeroConfig.instance:getHeroAttributeCO(iter_73_5)

		arg_73_0._attributevalues[iter_73_4].name.text = var_73_18.name

		CharacterController.instance:SetAttriIcon(arg_73_0._attributevalues[iter_73_4].icon, iter_73_5, var_0_0.AttrIconColor)

		local var_73_19 = arg_73_0._levelUpAttributeValues[iter_73_4]

		var_73_19.value.text = var_73_17
		var_73_19.name.text = var_73_18.name

		CharacterController.instance:SetAttriIcon(var_73_19.icon, iter_73_5, var_0_0.AttrIconColor)
	end
end

function var_0_0._refreshAttributeTips(arg_74_0, arg_74_1)
	local var_74_0 = arg_74_0._heroMO
	local var_74_1 = var_74_0.level

	if not arg_74_1 or arg_74_1 < var_74_1 then
		for iter_74_0, iter_74_1 in ipairs(arg_74_0._levelUpAttributeValues) do
			iter_74_1.newValue.text = 0
		end

		return
	end

	local var_74_2 = arg_74_1 == var_74_1
	local var_74_3 = var_74_0:getHeroBaseAttrDict(arg_74_1)
	local var_74_4 = HeroConfig.instance:talentGainTab2IDTab(var_74_0:getTalentGain(arg_74_1))
	local var_74_5 = var_74_0.destinyStoneMo
	local var_74_6 = var_74_5:getAddAttrValues()
	local var_74_7 = {}

	for iter_74_2, iter_74_3 in ipairs(var_0_0.AttrIdList) do
		var_74_7[iter_74_3] = 0
	end

	if var_74_0:hasDefaultEquip() then
		local var_74_8 = EquipModel.instance:getEquip(var_74_0.defaultEquipUid)
		local var_74_9, var_74_10, var_74_11, var_74_12 = EquipConfig.instance:getEquipAddBaseAttr(var_74_8)

		var_74_7[CharacterEnum.AttrId.Attack] = var_74_10
		var_74_7[CharacterEnum.AttrId.Hp] = var_74_9
		var_74_7[CharacterEnum.AttrId.Defense] = var_74_11
		var_74_7[CharacterEnum.AttrId.Mdefense] = var_74_12

		local var_74_13 = EquipConfig.instance:getEquipBreakAddAttrValueDict(var_74_8.config, var_74_8.breakLv)

		for iter_74_4, iter_74_5 in ipairs(var_0_0.AttrIdList) do
			local var_74_14 = var_74_13[iter_74_5]

			if var_74_14 ~= 0 then
				var_74_7[iter_74_5] = var_74_7[iter_74_5] + math.floor(var_74_14 / 100 * var_74_3[iter_74_5])
			end
		end
	end

	for iter_74_6, iter_74_7 in ipairs(var_0_0.AttrIdList) do
		local var_74_15 = var_74_4[iter_74_7] and var_74_4[iter_74_7].value and math.floor(var_74_4[iter_74_7].value) or 0
		local var_74_16 = var_74_5 and var_74_5:getAddValueByAttrId(var_74_6, iter_74_7, var_74_0) or 0
		local var_74_17 = var_74_3[iter_74_7] + var_74_7[iter_74_7] + var_74_15 + var_74_16
		local var_74_18 = arg_74_0._levelUpAttributeValues[iter_74_6]
		local var_74_19 = var_74_18.newValue

		var_74_19.text = var_74_17

		local var_74_20 = var_74_2 and "#C7C3C0" or "#65B96F"

		var_74_19.color = GameUtil.parseColor(var_74_20)
		var_74_18.newValueArrow.color = GameUtil.parseColor(var_74_20)
	end
end

function var_0_0._refreshLevel(arg_75_0)
	local var_75_0 = HeroConfig.instance:getShowLevel(arg_75_0._heroMO.level)
	local var_75_1 = HeroConfig.instance:getShowLevel(CharacterModel.instance:getrankEffects(arg_75_0._heroMO.heroId, arg_75_0._heroMO.rank)[1])
	local var_75_2 = var_75_0 .. "/"

	if arg_75_0._heroMO:getIsBalance() then
		var_75_2 = string.format("<color=#81abe5>%s</color>/", var_75_0)
	end

	arg_75_0._txtlevel.text = var_75_2
	arg_75_0._txtlevelmax.text = var_75_1
end

function var_0_0._refreshRank(arg_76_0)
	local var_76_0 = arg_76_0._heroMO.config.rare
	local var_76_1 = arg_76_0._heroMO.rank
	local var_76_2 = HeroConfig.instance:getMaxRank(var_76_0)

	for iter_76_0 = 1, 3 do
		gohelper.setActive(arg_76_0._ranklights[iter_76_0].go, var_76_2 == iter_76_0)

		for iter_76_1 = 1, iter_76_0 do
			if iter_76_1 <= var_76_1 - 1 then
				SLFramework.UGUI.GuiHelper.SetColor(arg_76_0._ranklights[iter_76_0].lights[iter_76_1]:GetComponent("Image"), "#feb73b")
			else
				SLFramework.UGUI.GuiHelper.SetColor(arg_76_0._ranklights[iter_76_0].lights[iter_76_1]:GetComponent("Image"), "#737373")
			end
		end
	end
end

function var_0_0._refreshSkill(arg_77_0)
	arg_77_0._skillContainer:onUpdateMO(arg_77_0._heroMO.heroId, nil, arg_77_0._heroMO)
end

function var_0_0._onRefreshDestiny(arg_78_0, arg_78_1, arg_78_2)
	arg_78_0:_refreshSkill()
end

function var_0_0._refreshPassiveSkill(arg_79_0)
	local var_79_0 = arg_79_0._heroMO:getpassiveskillsCO()
	local var_79_1 = var_79_0[1].skillPassive
	local var_79_2 = lua_skill.configDict[var_79_1]

	if not var_79_2 then
		logError("找不到被动技能, skillId: " .. tostring(var_79_1))

		return
	end

	arg_79_0._txtpassivename.text = var_79_2.name

	for iter_79_0 = 1, #var_79_0 do
		local var_79_3 = CharacterModel.instance:isPassiveUnlockByHeroMo(arg_79_0._heroMO, iter_79_0)

		gohelper.setActive(arg_79_0._passiveskillitems[iter_79_0].on, var_79_3)
		gohelper.setActive(arg_79_0._passiveskillitems[iter_79_0].off, not var_79_3)
		gohelper.setActive(arg_79_0._passiveskillitems[iter_79_0].go, true)
	end

	for iter_79_1 = #var_79_0 + 1, #arg_79_0._passiveskillitems do
		gohelper.setActive(arg_79_0._passiveskillitems[iter_79_1].go, false)
	end
end

function var_0_0._refreshExSkill(arg_80_0)
	for iter_80_0 = 1, 5 do
		if iter_80_0 <= arg_80_0._heroMO.exSkillLevel then
			SLFramework.UGUI.GuiHelper.SetColor(arg_80_0._exskills[iter_80_0]:GetComponent("Image"), "#feb73b")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_80_0._exskills[iter_80_0]:GetComponent("Image"), "#737373")
		end
	end
end

function var_0_0._refreshTalent(arg_81_0)
	local var_81_0 = arg_81_0._heroMO:isOwnHero()
	local var_81_1 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Talent) or not var_81_0
	local var_81_2 = false
	local var_81_3 = arg_81_0._heroMO:isOtherPlayerHero()
	local var_81_4

	if var_81_3 then
		var_81_2 = arg_81_0._heroMO:getOtherPlayerIsOpenTalent()
	else
		var_81_2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) or arg_81_0._heroMO:isTrial()
	end

	gohelper.setActive(arg_81_0._gotalent, var_81_1)
	gohelper.setActive(arg_81_0._gotalentlock, not var_81_2)
	ZProj.UGUIHelper.SetGrayscale(arg_81_0._gotalents, not var_81_2)
	arg_81_0:_showTalentStyleBtn()

	arg_81_0._txttalentvalue.text = HeroResonanceConfig.instance:getTalentConfig(arg_81_0._heroMO.heroId, arg_81_0._heroMO.talent + 1) and arg_81_0._heroMO.talent or luaLang("character_max_overseas")
end

function var_0_0._showTalentStyleBtn(arg_82_0)
	local var_82_0 = arg_82_0._heroMO:isOwnHero()
	local var_82_1 = TalentStyleModel.instance:isUnlockStyleSystem(arg_82_0._heroMO.talent)

	if not var_82_0 and not var_82_1 and not var_82_1 then
		arg_82_0:_showTalentBtn()

		return
	end

	local var_82_2 = arg_82_0._heroMO:getHeroUseCubeStyleId()
	local var_82_3 = arg_82_0._heroMO.talentCubeInfos:getMainCubeMo()

	if var_82_2 == 0 or not var_82_3 then
		arg_82_0:_showTalentBtn()

		return
	end

	local var_82_4 = var_82_3.id
	local var_82_5 = HeroResonanceConfig.instance:getTalentStyle(var_82_4)
	local var_82_6 = var_82_5 and var_82_5[var_82_2]

	if var_82_6 then
		local var_82_7, var_82_8 = var_82_6:getStyleTagIcon()
		local var_82_9 = var_82_6._styleCo.color

		arg_82_0._imageicon.color = GameUtil.parseColor(var_82_9)

		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_82_0._imageicon, var_82_8)
		gohelper.setActive(arg_82_0._gotalentstyle, true)
		gohelper.setActive(arg_82_0._gotalents, false)
	else
		arg_82_0:_showTalentBtn()
	end
end

function var_0_0._showTalentBtn(arg_83_0)
	gohelper.setActive(arg_83_0._gotalentstyle, false)
	gohelper.setActive(arg_83_0._gotalents, true)
end

function var_0_0._onRefreshStyleIcon(arg_84_0)
	arg_84_0:_showTalentStyleBtn()
end

function var_0_0.onClose(arg_85_0)
	if arg_85_0._drag then
		arg_85_0._drag:RemoveDragBeginListener()
		arg_85_0._drag:RemoveDragEndListener()
		arg_85_0._drag:RemoveDragListener()
	end

	if arg_85_0._signatureDrag then
		arg_85_0._signatureDrag:RemoveDragBeginListener()
		arg_85_0._signatureDrag:RemoveDragEndListener()
		arg_85_0._signatureDrag:RemoveDragListener()
	end

	arg_85_0._trustclick:RemoveClickListener()
	arg_85_0._careerclick:RemoveClickListener()
	arg_85_0._signatureClick:RemoveClickListener()

	if arg_85_0._uiSpine then
		arg_85_0._uiSpine:stopVoice()
	end

	if arg_85_0._dragTweenId then
		ZProj.TweenHelper.KillById(arg_85_0._dragTweenId)

		arg_85_0._dragTweenId = nil
	end

	TaskDispatcher.cancelTask(arg_85_0._playSpineVoice, arg_85_0)
	TaskDispatcher.cancelTask(arg_85_0._delaySetModelHide, arg_85_0)
	arg_85_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_85_0._onCloseViewFinish, arg_85_0)
	arg_85_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_85_0._onCloseFullView, arg_85_0)
	arg_85_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_85_0._onCloseView, arg_85_0)
end

function var_0_0.onUpdateParam(arg_86_0)
	arg_86_0._playGreetingVoices = true

	arg_86_0:clear()
	arg_86_0:_refreshView()
end

function var_0_0.clear(arg_87_0)
	arg_87_0._simagestatic:UnLoadImage()
	arg_87_0._simagesignature:UnLoadImage()
end

function var_0_0.playCloseViewAnim(arg_88_0, arg_88_1)
	if arg_88_0._tempFunc then
		TaskDispatcher.cancelTask(arg_88_0._tempFunc, arg_88_0)
	end

	arg_88_0:playAnim(UIAnimationName.Close)

	arg_88_0._tempFunc = arg_88_1

	UIBlockMgr.instance:startBlock(arg_88_0.viewName .. "ViewCloseAnim")
	TaskDispatcher.runDelay(arg_88_0._closeAnimFinish, arg_88_0, 0.18)
end

function var_0_0._closeAnimFinish(arg_89_0)
	UIBlockMgr.instance:endBlock(arg_89_0.viewName .. "ViewCloseAnim")
	arg_89_0:_tempFunc()
end

function var_0_0.playAnim(arg_90_0, arg_90_1)
	arg_90_0._isAnim = true

	arg_90_0:setShaderKeyWord()
	arg_90_0._animator:Play(arg_90_1, arg_90_0.onAnimDone, arg_90_0)
end

function var_0_0.onAnimDone(arg_91_0)
	arg_91_0._isAnim = false

	arg_91_0:setShaderKeyWord()
end

function var_0_0.setShaderKeyWord(arg_92_0)
	if arg_92_0._isDragingSpine or arg_92_0._isAnim then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function var_0_0.onDestroyView(arg_93_0)
	if arg_93_0._uiSpine then
		arg_93_0._uiSpine:onDestroy()

		arg_93_0._uiSpine = nil
	end

	arg_93_0._simageplayerbg:UnLoadImage()
	arg_93_0._simagebg:UnLoadImage()
	arg_93_0:clear()
	TaskDispatcher.cancelTask(arg_93_0._closeAnimFinish, arg_93_0)
	TaskDispatcher.cancelTask(arg_93_0._delaySetModelHide, arg_93_0)
	TaskDispatcher.cancelTask(arg_93_0._playSpineVoice, arg_93_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

return var_0_0
