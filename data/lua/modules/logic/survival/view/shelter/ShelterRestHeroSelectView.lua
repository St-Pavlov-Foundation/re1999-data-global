module("modules.logic.survival.view.shelter.ShelterRestHeroSelectView", package.seeall)

local var_0_0 = class("ShelterRestHeroSelectView", SurvivalInitHeroSelectView)

function var_0_0.getGroupModel(arg_1_0)
	if not arg_1_0.notIsFirst then
		arg_1_0.notIsFirst = true

		ShelterRestGroupModel.instance:initViewParam(arg_1_0.viewParam)
	end

	return ShelterRestGroupModel.instance
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0._groupModel = arg_2_0:getGroupModel()
	arg_2_0._isShowQuickEdit = true
	arg_2_0._scrollcard.verticalNormalizedPosition = 1
	arg_2_0._scrollquickedit.verticalNormalizedPosition = 1

	for iter_2_0 = 1, 2 do
		arg_2_0._selectDmgs[iter_2_0] = false
	end

	for iter_2_1 = 1, 6 do
		arg_2_0._selectAttrs[iter_2_1] = false
	end

	for iter_2_2 = 1, 6 do
		arg_2_0._selectLocations[iter_2_2] = false
	end

	arg_2_0._heroMO = arg_2_0._groupModel:getList()[arg_2_0._groupModel.defaultIndex]

	arg_2_0:_refreshEditMode()
	arg_2_0:_refreshBtnIcon()
	arg_2_0:_refreshCharacterInfo()
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_2_0._updateHeroList, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_2_0._updateHeroList, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_2_0._updateHeroList, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_2_0._onHeroItemClick, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_2_0._refreshCharacterInfo, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_2_0._refreshCharacterInfo, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_2_0._refreshCharacterInfo, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_2_0._refreshCharacterInfo, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_2_0._refreshCharacterInfo, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_2_0._onAttributeChanged, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_2_0._showCharacterRankUpView, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, arg_2_0._markFavorSuccess, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_2_0._refreshCharacterInfo, arg_2_0)
	arg_2_0:addEventCb(AudioMgr.instance, AudioMgr.Evt_Trigger, arg_2_0._onAudioTrigger, arg_2_0)
	gohelper.addUIClickAudio(arg_2_0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_2_0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_2_0._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_2_0._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_2_0._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_2_0._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, arg_2_0._initScrollContentPosY = transformhelper.getLocalPos(arg_2_0._goScrollContent.transform)
end

function var_0_0.onClose(arg_3_0)
	var_0_0.super.onClose(arg_3_0)

	arg_3_0.notIsFirst = nil
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	if not arg_4_0._isShowQuickEdit then
		arg_4_0._groupModel:trySetHeroMo(arg_4_0._heroMO)
	end

	arg_4_0._groupModel:saveHeroGroup()
	arg_4_0:closeThis()
end

return var_0_0
