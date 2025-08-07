module("modules.logic.character.defines.CharacterViewDefine", package.seeall)

return {
	init = function(arg_1_0)
		arg_1_0.CharacterSkillTalentView = {
			destroy = 0,
			container = "CharacterSkillTalentViewContainer",
			mainRes = "ui/viewres/character/extra/characterskilltalentview.prefab",
			layer = "POPUP_TOP",
			viewType = ViewType.Full,
			anim = ViewAnim.Default,
			tabRes = {
				{
					{
						NavigateButtonsView.prefabPath
					}
				}
			}
		}
		arg_1_0.CharacterWeaponView = {
			destroy = 0,
			container = "CharacterWeaponViewContainer",
			mainRes = "ui/viewres/character/extra/characterweaponview.prefab",
			layer = "POPUP_TOP",
			viewType = ViewType.Full,
			anim = ViewAnim.Default,
			tabRes = {
				{
					{
						NavigateButtonsView.prefabPath
					}
				}
			}
		}
		arg_1_0.CharacterWeaponEffectView = {
			bgBlur = 1,
			container = "CharacterWeaponEffectViewContainer",
			mainRes = "ui/viewres/character/extra/characterweaponeffectview.prefab",
			destroy = 0,
			blurIterations = 3,
			blurFactor = 0.85,
			layer = "POPUP_TOP",
			viewType = ViewType.Modal,
			anim = ViewAnim.Default,
			desampleRate = PostProcessingMgr.DesamplingRate.x8,
			reduceRate = PostProcessingMgr.DesamplingRate.x8
		}
	end
}
