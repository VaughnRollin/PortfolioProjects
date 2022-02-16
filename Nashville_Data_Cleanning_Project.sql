-- Base data cleaning

SELECT *
FROM PortfolioProject..NashHousing

SELECT SaleDate
FROM PortfolioProject..NashHousing

-- Removing SaleDate timestamp because it does not serve a purpose

SELECT SaleDate, CONVERT(Date,SaleDate) AS corrected_preview
FROM PortfolioProject..NashHousing

UPDATE NashHousing
SET SaleDate = CONVERT(Date,SaleDate)

SELECT *
FROM PortfolioProject..NashHousing

-- For some reason UPDATE did not take affect even though SQL said it ran correctly affecting all rows (56,477)

ALTER TABLE NashHousing
ADD SaleDateConverted Date;

UPDATE NashHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

SELECT SaleDateConverted
FROM PortfolioProject..NashHousing


-- Property Address data cleanning 

SELECT PropertyAddress
FROM PortfolioProject..NashHousing

SELECT PropertyAddress
FROM PortfolioProject..NashHousing
Where PropertyAddress IS NULL

SELECT *
FROM PortfolioProject..NashHousing
Where PropertyAddress IS NULL

-- With wanting to deal with NULL values I looked throuhg the data and found that ParcellID and PropertyAdress have duplicates and that
--ParcellID could be used to help fill in NULL values

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..NashHousing a
JOIN PortfolioProject..NashHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..NashHousing a
JOIN PortfolioProject..NashHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress IS NULL

SELECT *
FROM PortfolioProject..NashHousing
Where PropertyAddress IS NULL

-- Seperating Address by Address, City

SELECT PropertyAddress
FROM PortfolioProject..NashHosing

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS Address
FROM PortfolioProject..NashHousing

ALTER TABLE NashHousing
ADD PropertySplitAddress NVARCHAR(255);

UPDATE NashHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE NashHousing
ADD PropertySplitCity NVARCHAR(255);

UPDATE NashHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))



-- Spliting Owner Address now by address, city, state

SELECT OwnerAddress
FROM PortfolioProject..NashHousing

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',' , '.'),3)
,PARSENAME(REPLACE(OwnerAddress, ',' , '.'),2)
,PARSENAME(REPLACE(OwnerAddress, ',' , '.'),1)
FROM PortfolioProject..NashHousing



ALTER TABLE NashHousing
ADD OwnerSplitAddress NVARCHAR(255);

UPDATE NashHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',' , '.'),3)

ALTER TABLE NashHousing
ADD OwnerSplitCity NVARCHAR(255);

UPDATE NashHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',' , '.'),2)

ALTER TABLE NashHousing
ADD OwnerSplitState NVARCHAR(255);

UPDATE NashHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',' , '.'),1)


-- Updating certain values in SoldAsVacant from Y or N to Yes or No

SELECT SoldAsVacant
From PortfolioProject..NashHousing

SELECT DISTINCT(SoldAsVacant)
From PortfolioProject..NashHousing

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
From PortfolioProject..NashHousing
GROUP BY SoldAsVacant
ORDER BY 2	

SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
       WHEN SoldAsVacant = 'N' THEN 'No'
       ELSE SoldAsVacant
	   END
From PortfolioProject..NashHousing


UPDATE NashHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
       WHEN SoldAsVacant = 'N' THEN 'No'
       ELSE SoldAsVacant
	   END

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
From PortfolioProject..NashHousing
GROUP BY SoldAsVacant
ORDER BY 2	



-- Removing Duplicates
WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelId,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
From PortfolioProject..NashHousing
)
DELETE
FROM RowNumCTE
WHERE row_num > 1


WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelId,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
From PortfolioProject..NashHousing
)
SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress

ALTER TABLE PortfolioProject..NashHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

SELECT *
FROM PortfolioProject..NashHousing

ALTER TABLE PortfolioProject..NashHousing
DROP COLUMN SaleDate

SELECT *
FROM PortfolioProject..NashHousing
