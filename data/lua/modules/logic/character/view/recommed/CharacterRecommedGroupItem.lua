module("modules.logic.character.view.recommed.CharacterRecommedGroupItem", package.seeall)

local var_0_0 = class("CharacterRecommedGroupItem", ListScrollCell)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#txt_index")
	arg_1_0._goherogrouplist = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_herogrouplist")
	arg_1_0._btnuse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/#btn_use")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnuse:AddClickListener(arg_2_0._btnuseOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnuse:RemoveClickListener()
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.viewGO = arg_4_1

	arg_4_0:onInitView()
end

function var_0_0._btnuseOnClick(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._groupList) do
		local var_5_1 = HeroModel.instance:getByHeroId(iter_5_1)

		if var_5_1 then
			local var_5_2 = HeroSingleGroupPresetMO.New()

			var_5_2:init(iter_5_0, var_5_1.uid)
			table.insert(var_5_0, var_5_2)
		end
	end

	local var_5_3 = {
		replaceTeamList = var_5_0
	}

	HeroGroupPresetController.instance:openHeroGroupPresetTeamView(var_5_3)
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0._editableAddEvents(arg_7_0)
	return
end

function var_0_0._editableRemoveEvents(arg_8_0)
	return
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_0._goheroitem then
		arg_9_0._goheroitem = arg_9_2:getHeroIconRes()
	end

	arg_9_0._groupList = arg_9_1
	arg_9_0._recommendMo = arg_9_3

	gohelper.CreateObjList(arg_9_0, arg_9_0._groupItemCB, arg_9_1, arg_9_0._goherogrouplist.gameObject, arg_9_0._goheroitem, CharacterRecommedHeroIcon)
	gohelper.setActive(arg_9_0.viewGO, true)
	arg_9_0:showUseBtn()

	arg_9_0.viewName = arg_9_2.viewName
end

function var_0_0.showUseBtn(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 and arg_10_0._recommendMo and arg_10_0._recommendMo:isOwnHero()

	gohelper.setActive(arg_10_0._btnuse.gameObject, arg_10_1)
end

function var_0_0.setIndex(arg_11_0, arg_11_1)
	arg_11_0._txtindex.text = arg_11_1 >= 10 and arg_11_1 or "0" .. arg_11_1
end

function var_0_0._groupItemCB(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = CharacterRecommedModel.instance:getHeroRecommendMo(arg_12_2)

	arg_12_1:onUpdateMO(var_12_0)
	arg_12_1:setClickCallback(function()
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = var_12_0.heroId,
			formView = arg_12_0.viewName
		})
	end, arg_12_0)

	local var_12_1 = var_12_0:isOwnHero()

	arg_12_1:SetGrayscale(not var_12_1)
end

function var_0_0.playViewAnim(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if not arg_14_0._viewAnim then
		arg_14_0._viewAnim = arg_14_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if arg_14_0._viewAnim then
		arg_14_0._viewAnim:Play(arg_14_1, arg_14_2, arg_14_3)
	end
end

function var_0_0.onSelect(arg_15_0, arg_15_1)
	return
end

function var_0_0.onDestroy(arg_16_0)
	return
end

return var_0_0
