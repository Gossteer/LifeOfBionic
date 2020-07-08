use Life_of_Bionic
go

alter procedure Select_Diagnos_ForPosa
as
SELECT Diagnosis.id_Diagnoz,  dbo.DirectoryDisease.Name_Disease + ' ' +
convert(varchar,dbo.Diagnosis.TimeDisease) +  'дня, ' + dbo.Medicament.Name_Medicament + ' ' +
convert(varchar,dbo.Diagnosis.Amount) + ' штук, ' + dbo.TypeUse.Name_Use + ', пал: №' + convert(varchar,dbo.TherapeuticDepartament.id_Room) as 'Диагнозыыы'
FROM     dbo.Diagnosis INNER JOIN
                  dbo.DirectoryDisease ON dbo.Diagnosis.id_Disease = dbo.DirectoryDisease.id_Disease INNER JOIN
                  dbo.Medicament ON dbo.Diagnosis.id_Medicament = dbo.Medicament.id_Medicament INNER JOIN
                  dbo.TherapeuticDepartament ON dbo.Diagnosis.ID_Room = dbo.TherapeuticDepartament.id_Room INNER JOIN
                  dbo.CategoriesDisease ON dbo.TherapeuticDepartament.id_CategoriesDisease = dbo.CategoriesDisease.id_CategoriesDisease INNER JOIN
                  dbo.TypeUse ON dbo.Diagnosis.id_TypeUse = dbo.TypeUse.id_TypeUse
WHERE dbo.Diagnosis.Diagnosis_Logical_Delete = 0
