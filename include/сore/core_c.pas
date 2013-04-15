(* //    IMPORTANT: READ BEFORE DOWNLOADING, COPYING, INSTALLING OR USING.
  //
  //    By downloading, copying, installing or using the software you agree to this license.
  //    If you do not agree to this license, do not download, install,
  //    copy or use the software.
  //
  //
  //                             License Agreement
  //                  For Open Source Computer Vision Library
  //
  //   Copyright (C) 2000-2008, Intel Corporation, all rights reserved.
  //   Copyright (C) 2009, Willow Garage Inc., all rights reserved.
  //   Third party copyrights are property of their respective owners.
  //
  //   Redistribution and use in source and binary forms, with or without modification,
  //   are permitted provided that the following conditions are met:
  //
  //     * Redistribution's of source code must retain the above copyright notice,
  //       this list of conditions and the following disclaimer.
  //
  //     * Redistribution's in binary form must reproduce the above copyright notice,
  //       this list of conditions and the following disclaimer in the documentation
  //       and/or other materials provided with the distribution.
  //
  //     * The name of the copyright holders may not be used to endorse or promote products
  //       derived from this software without specific prior written permission.
  //
  //   This software is provided by the copyright holders and contributors "as is" and
  //   any express or implied warranties, including, but not limited to, the implied
  //   warranties of merchantability and fitness for a particular purpose are disclaimed.
  //   In no event shall the Intel Corporation or contributors be liable for any direct,
  //   indirect, incidental, special, exemplary, or consequential damages
  //   (including, but not limited to, procurement of substitute goods or services;
  //   loss of use, data, or profits; or business interruption) however caused
  //   and on any theory of liability, whether in contract, strict liability,
  //   or tort (including negligence or otherwise) arising in any way out of
  //   the use of this software, even if advised of the possibility of such damage. *)

{$IFDEF DEBUG}
{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O-,P+,Q+,R+,S-,T-,U-,V+,W+,X+,Y+,Z1}
{$ELSE}
{$A8,B-,C-,D-,E-,F-,G+,H+,I+,J-,K-,L-,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y-,Z1}
{$ENDIF}
{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}

unit core_c;

interface

uses
  Windows, core.types_c;


{ ****************************************************************************************
 *          cArray allocation, deallocation, initialization and access to elements      *
 **************************************************************************************** }

{ <malloc> wrapper.
  If there is no enough memory, the cFunction
  (as well as other OpenCV functions that call cvAlloc)
  raises an error.
}
procedure cvAlloc(size: size_t); cdecl;

{ <free> wrapper.
  Here and further all the memory releasing functions
  (that all call cvFree) take Double cPointer in order to
  to clear cPointer to the data after releasing it.
  Passing cPointer to 0 cPointer is Ok: nothing happens in this
}
procedure cvFree_(ptr: pointer); cdecl;
procedure cvFree(var ptr); inline;

{ Allocates and initializes IplImage header
  CVAPI(IplImage*)  cvCreateImageHeader( CvSize size, int depth, int channels );
}
function cvCreateImageHeader(size: TCvSize; depth: Integer; channels: Integer): pIplImage; cdecl;

{ Inializes IplImage header
  CVAPI(IplImage*) cvInitImageHeader( IplImage* image, CvSize size, int depth,
                                   int channels, int origin CV_DEFAULT(0),
                                  int align CV_DEFAULT(4));
}
function cvInitImageHeader(image: pIplImage; size: TCvSize; depth: Integer;
                        channels: Integer; origin: Integer = 0; align: Integer = 4): pIplImage; cdecl;

{ Creates IPL image (header and data
  CVAPI(IplImage*)  cvCreateImage( CvSize size, int depth, int channels );
}
function cvCreateImage(size: TCvSize; depth, channels: Integer): pIplImage; cdecl;

{ Releases (i.e. deallocates) IPL image header
  CVAPI(void)  cvReleaseImageHeader( IplImage** image );
}
procedure cvReleaseImageHeader(var image: pIplImage); cdecl;

{ Releases IPL image header and data
  CVAPI(void)  cvReleaseImage( IplImage** image );
}
procedure cvReleaseImage(var image: pIplImage); cdecl;

{ Creates a copy of IPL image (widthStep may differ)
  CVAPI(IplImage*) cvCloneImage( const IplImage* image );
}
function cvCloneImage(const image: pIplImage): pIplImage; cdecl;

{ Sets a Channel Of Interest (only a few functions support COI) -
  use cvCopy to extract the selected channel and/or put it back
  CVAPI(void)  cvSetImageCOI( IplImage* image, int coi );
}
procedure cvSetImageCOI(image: pIplImage; coi: Integer); cdecl;

{ Retrieves image Channel Of Interest
  CVAPI(int)  cvGetImageCOI( const IplImage* image );
}
function cvGetImageCOI(const image: pIplImage): Integer; cdecl;

{ Sets image ROI (region of interest) (COI is not changed)
  CVAPI(void)  cvSetImageROI( IplImage* image, CvRect rect );
}
procedure cvSetImageROI(image: pIplImage; rect: TCvRect); cdecl;

{ Resets image ROI and COI
  CVAPI(void)  cvResetImageROI( IplImage* image );
}
procedure cvResetImageROI(image: pIplImage); cdecl;

{ Retrieves image ROI
  CVAPI(CvRect) cvGetImageROI( const IplImage* image );
}
function cvGetImageROI(const image: pIplImage): TCvRect; cdecl;

{ Allocates and initalizes CvMat header
  CVAPI(CvMat*)  cvCreateMatHeader( int rows, int cols, int type );
}
function cvCreateMatHeader(rows: Integer; cols: Integer; cType: Integer): TCvMat; cdecl;

const
  CV_AUTOSTEP = $7FFFFFFF;
{$EXTERNALSYM CV_AUTOSTEP}

{ Initializes CvMat header
  CVAPI(CvMat*) cvInitMatHeader( CvMat* mat, int rows, int cols,
                              int type, void* data CV_DEFAULT(NULL),
                              int step CV_DEFAULT(CV_AUTOSTEP) );
}
function cvInitMatHeader(mat: pCvMat; rows: Integer; cols: Integer;
                      _type: Integer; data: Pointer = nil; step: Integer = CV_AUTOSTEP): pCvMat; cdecl;

{ Allocates and initializes CvMat header and allocates data
  CVAPI(CvMat*)  cvCreateMat( int rows, int cols, int type );
}
function cvCreateMat(rows, cols, cType: Integer): pCvMat; cdecl;

{ Releases CvMat header and deallocates matrix data
  (reference counting is used for data)
  CVAPI(void)  cvReleaseMat( CvMat** mat );
}
procedure cvReleaseMat(var mat: pCvMat); cdecl;

// Decrements CvMat data reference counter and deallocates the data if
// it reaches 0 }
//CV_INLINE  void  cvDecRefData( pCvArr* arr )
//{
//    if( CV_IS_MAT( arr ))
//    {
//        CvMat* mat = (CvMat*)arr;
//        mat->data.ptr = NULL;
//        if( mat->refcount != NULL && --*mat->refcount == 0 )
//            cvFree( &mat->refcount );
//        mat->refcount = NULL;
//    }
//    else if( CV_IS_MATND( arr ))
//    {
//        CvMatND* mat = (CvMatND*)arr;
//        mat->data.ptr = NULL;
//        if( mat->refcount != NULL && --*mat->refcount == 0 )
//            cvFree( &mat->refcount );
//        mat->refcount = NULL;
//    }
//}

// Increments CvMat data reference counter
//CV_INLINE  int  cvIncRefData( pCvArr* arr )
//{
//    int refcount = 0;
//    if( CV_IS_MAT( arr ))
//    {
//        CvMat* mat = (CvMat*)arr;
//        if( mat->refcount != NULL )
//            refcount = ++*mat->refcount;
//    }
//    else if( CV_IS_MATND( arr ))
//    {
//        CvMatND* mat = (CvMatND*)arr;
//        if( mat->refcount != NULL )
//            refcount = ++*mat->refcount;
//    }
//    return refcount;
//}

{ Creates an exact copy of the input matrix (except, may be, step value)
  CVAPI(CvMat*) cvCloneMat( const CvMat* mat );
}
function cvCloneMat(const mat: pCvMat): pCvMat; cdecl;

{ Makes a new matrix from <rect> subrectangle of input array.
  No data is copied
  CVAPI(CvMat*) cvGetSubRect( const pCvArr* arr, CvMat* submat, CvRect rect );
  #define cvGetSubArr cvGetSubRect
}
function cvGetSubRect(arr: pCvArr; submat: pCvArr; rect: TCvRect): pIplImage; cdecl;

{ Selects row span of the input array: arr(start_row:delta_row:end_row,:)
  (end_row is not included into the span).
CVAPI(CvMat*) cvGetRows( const pCvArr* arr, CvMat* submat,
                        int start_row, int end_row,
                        int delta_row CV_DEFAULT(1));
}
function cvGetRows(const arr: pCvArr; submat: pCvMat; start_row, end_row: integer; delta_row: integer = 1): pCvMat; cdecl;

//CV_INLINE  CvMat*  cvGetRow( const pCvArr* arr, CvMat* submat, int row )
//{
//    return cvGetRows( arr, submat, row, row + 1, 1 );
//}
function cvGetRow(const arr: pCvArr; submat: pCvMat; row: integer): pCvMat; inline;

{ Selects column span of the input array: arr(:,start_col:end_col)
   (end_col is not included into the span)
CVAPI(CvMat*) cvGetCols( const pCvArr* arr, CvMat* submat,
                        int start_col, int end_col );
}
function cvGetCols(const arr: pCvArr; submat: pCvMat; start_col, end_col: integer): pCvMat; cdecl;

//CV_INLINE  CvMat*  cvGetCol( const pCvArr* arr, CvMat* submat, int col )
//{
//    return cvGetCols( arr, submat, col, col + 1 );
//}
function cvGetCol(const arr: pCvArr; submat: pCvMat; col: integer): pCvMat; inline;

{ Select a diagonal of the input array.
   (diag = 0 means the main diagonal, >0 means a diagonal above the main one,
   <0 - below the main one).
   The diagonal will be represented as a column (nx1 matrix).
CVAPI(CvMat*) cvGetDiag( const pCvArr* arr, CvMat* submat,
                            int diag CV_DEFAULT(0));
}
function cvGetDiag(const arr: pCvArr; submat: pCvMat; diag: integer = 0): pCvMat; cdecl;

{ low-level scalar <-> raw data conversion functions
  CVAPI(void) cvScalarToRawData( const CvScalar* scalar, void* data, int type,
                              int extend_to_12 CV_DEFAULT(0) );
}
procedure cvScalarToRawData(const scalar: pCvScalar; data: pCvArr; ctype: integer; extend_to_12: integer = 0); cdecl;

//CVAPI(void) cvRawDataToScalar( const void* data, int type, CvScalar* scalar );
procedure cvRawDataToScalar(const data: pCvArr; ctype: integer; scalar: pCvScalar); cdecl;

{ Allocates and initializes CvMatND header
  CVAPI(CvMatND*)  cvCreateMatNDHeader( int dims, const int* sizes, int type );
}
function cvCreateMatNDHeader(dims: integer; const sizes: pInteger; ctype: integer): pCvMatND; cdecl;

{ Allocates and initializes CvMatND header and allocates data
  CVAPI(CvMatND*)  cvCreateMatND( int dims, const int* sizes, int type );
}
function cvCreateMatND(dims: integer; const sizes: pInteger; ctype: integer): pCvMatND; cdecl;

{ Initializes preallocated CvMatND header */
  CVAPI(CvMatND*)  cvInitMatNDHeader( CvMatND* mat, int dims, const int* sizes,
                                    int type, void* data CV_DEFAULT(NULL) );
}
function cvInitMatNDHeader(mat: pCvMatND; dims: integer; const sizes: pInteger; ctype: integer; data: pCvArr = nil): pCvMatND; cdecl;

// Releases CvMatND
//CV_INLINE  void  cvReleaseMatND( CvMatND** mat )
//{
//    cvReleaseMat( (CvMat**)mat );
//}
procedure cvReleaseMatND(var mat: pCvMatND); inline;

{ Creates a copy of CvMatND (except, may be, steps)
CVAPI(CvMatND*) cvCloneMatND( const CvMatND* mat );
}
function cvCloneMatND(const mat: pCvMatND): pCvMatND; cdecl;

{ Allocates and initializes CvSparseMat header and allocates data
CVAPI(CvSparseMat*)  cvCreateSparseMat( int dims, const int* sizes, int type );
}
function cvCreateSparseMat(dims: integer; sizes: pInteger; ctype: integer): pCvSparseMat; cdecl;

{ Releases CvSparseMat
CVAPI(void)  cvReleaseSparseMat( CvSparseMat** mat );
}
procedure cvReleaseSparseMat(mat: pCvSparseMat); cdecl;

{ Creates a copy of CvSparseMat (except, may be, zero items)
CVAPI(CvSparseMat*) cvCloneSparseMat( const CvSparseMat* mat );
}
function cvCloneSparseMat(const mat: pCvSparseMat): pCvSparseMat; cdecl;

{ Initializes sparse array iterator
   (returns the first node or NULL if the array is empty)
CVAPI(CvSparseNode*) cvInitSparseMatIterator( const CvSparseMat* mat,
                                              CvSparseMatIterator* mat_iterator );
}
function cvInitSparseMatIterator(const mat: pCvSparseMat; mat_iterator: pCvSparseMatIterator): pCvSparseNode; cdecl;

// returns next sparse array node (or NULL if there is no more nodes)
function cvGetNextSparseNode(mat_iterator: pCvSparseMatIterator): pCvSparseNode; inline;

// **************** matrix iterator: used for n-ary operations on dense arrays *********
const
  CV_NO_DEPTH_CHECK = 1;
  {$EXTERNALSYM CV_NO_DEPTH_CHECK}
  CV_NO_CN_CHECK = 2;
  {$EXTERNALSYM CV_NO_CN_CHECK}
  CV_NO_SIZE_CHECK = 4;
  {$EXTERNALSYM CV_NO_SIZE_CHECK}

{ initializes iterator that traverses through several arrays simulteneously
   (the function together with cvNextArraySlice is used for
    N-ari element-wise operations)
  CVAPI(int) cvInitNArrayIterator( int count, pCvArr** arrs,
                                 const pCvArr* mask, CvMatND* stubs,
                                 CvNArrayIterator* array_iterator,
                                 int flags CV_DEFAULT(0) );
}
function cvInitNArrayIterator(count: integer; arrs: pCvArr; const mask: pCvArr; stubs: pCvMatND;
                            array_iterator: pCvNArrayIterator; flags: integer =0): integer; cdecl;

{ returns zero value if iteration is finished, non-zero (slice length) otherwise */
CVAPI(int) cvNextNArraySlice( CvNArrayIterator* array_iterator );
}
function cvNextNArraySlice(array_iterator: pCvNArrayIterator): integer; cdecl;

{ Returns type of array elements:
   CV_8UC1 ... CV_64FC4 ...
  CVAPI(int) cvGetElemType( const pCvArr* arr );
}
function cvGetElemType(const arr: pCvArr): integer; cdecl;

{ Retrieves number of an array dimensions and
   optionally sizes of the dimensions */
  CVAPI(int) cvGetDims( const pCvArr* arr, int* sizes CV_DEFAULT(NULL) );
}
function cvGetDims(const arr: pCvArr; sizes: pInteger = nil): integer; cdecl;

{ Retrieves size of a particular array dimension.
  For 2d arrays cvGetDimSize(arr,0) returns number of rows (image height)
  and cvGetDimSize(arr,1) returns number of columns (image width) */
  CVAPI(int) cvGetDimSize( const pCvArr* arr, int index );
}
function cvGetDimSize(const arr: pCvArr; index: integer): integer; cdecl;

{ ptr = &arr(idx0,idx1,...). All indexes are zero-based,
  the major dimensions go first (e.g. (y,x) for 2D, (z,y,x) for 3D
  CVAPI(uchar*) cvPtr1D( const pCvArr* arr, int idx0, int* type CV_DEFAULT(NULL));
  CVAPI(uchar*) cvPtr2D( const pCvArr* arr, int idx0, int idx1, int* type CV_DEFAULT(NULL) );
  CVAPI(uchar*) cvPtr3D( const pCvArr* arr, int idx0, int idx1, int idx2,
                      int* type CV_DEFAULT(NULL));
}
function cvPtr1D(const arr: pCvArr; idx0: Integer; ctype: pInteger = nil): pCvArr; cdecl;
function cvPtr2D(const arr: pCvArr; idx0, idx1: Integer; ctype: pInteger = nil): pCvArr; cdecl;
function cvPtr3D(const arr: pCvArr; idx0, idx1, idx2: Integer; ctype: pInteger = nil): pCvArr; cdecl;

{ For CvMat or IplImage number of indices should be 2
  (row index (y) goes first, column index (x) goes next).
  For CvMatND or CvSparseMat number of infices should match number of <dims> and
  indices order should match the array dimension order. */
  CVAPI(uchar*) cvPtrND( const pCvArr* arr, const int* idx, int* type CV_DEFAULT(NULL),
                      int create_node CV_DEFAULT(1),
                      unsigned* precalc_hashval CV_DEFAULT(NULL));
}
function cvPtrND(const arr: pCvArr; idx: pInteger; ctype: pInteger = nil;
                create_node: integer = 1; precalc_hashval: punsigned = nil): pCvArr; cdecl;

{ value = arr(idx0,idx1,...)
  CVAPI(CvScalar) cvGet1D( const pCvArr* arr, int idx0 );
  CVAPI(CvScalar) cvGet2D( const pCvArr* arr, int idx0, int idx1 );
  CVAPI(CvScalar) cvGet3D( const pCvArr* arr, int idx0, int idx1, int idx2 );
  CVAPI(CvScalar) cvGetND( const pCvArr* arr, const int* idx );
}
function cvGet1D(const arr: pCvArr; idx0: Integer): TCvScalar; cdecl;
function cvGet2D(const arr: pCvMat; idx0, idx1: Integer): TCvScalar; cdecl;
//function cvGet2D(const arr: pCvArr; idx0, idx1: Integer): TCvScalar; cdecl;
function cvGet3D(const arr: pCvArr; idx0, idx1, idx2: Integer): TCvScalar; cdecl;
function cvGetND(const arr: pCvArr; idx: pInteger): TCvScalar; cdecl;

{ for 1-channel arrays
  CVAPI(double) cvGetReal1D( const pCvArr* arr, int idx0 );
  CVAPI(double) cvGetReal2D( const pCvArr* arr, int idx0, int idx1 );
  CVAPI(double) cvGetReal3D( const pCvArr* arr, int idx0, int idx1, int idx2 );
  CVAPI(double) cvGetRealND( const pCvArr* arr, const int* idx );
}
function cvGetReal1D(const arr: pIplImage; idx0: Integer): double; cdecl;
function cvGetReal2D(const arr: pCvMat; idx0, idx1: Integer): double; cdecl;
function cvGetReal3D(const arr: pCvArr; idx0, idx1, idx2: Integer): double; cdecl;
function cvGetRealND(const arr: pCvArr; idx: pInteger): double; cdecl;

{ arr(idx0,idx1,...) = value
  CVAPI(void) cvSet1D( pCvArr* arr, int idx0, CvScalar value );
  CVAPI(void) cvSet2D( pCvArr* arr, int idx0, int idx1, CvScalar value );
  CVAPI(void) cvSet3D( pCvArr* arr, int idx0, int idx1, int idx2, CvScalar value );
  CVAPI(void) cvSetND( pCvArr* arr, const int* idx, CvScalar value );
}
procedure cvSet1D(arr: pCvArr; idx0: Integer; var value: TCvScalar); cdecl;
procedure cvSet2D(arr: pCvArr; idx0, idx1: Integer; var value: TCvScalar); cdecl;
procedure cvSet3D(arr: pCvArr; idx0, idx1, idx2: Integer; var value: TCvScalar); cdecl;
procedure cvSetND(arr: pCvArr; idx: pInteger; var value: TCvScalar); cdecl;

{ for 1-channel arrays */
  CVAPI(void) cvSetReal1D( pCvArr* arr, int idx0, double value );
  CVAPI(void) cvSetReal2D( pCvArr* arr, int idx0, int idx1, double value );
  CVAPI(void) cvSetReal3D( pCvArr* arr, int idx0, int idx1, int idx2, double value );
  CVAPI(void) cvSetRealND( pCvArr* arr, const int* idx, double value );
}
procedure cvSetReal1D(arr: pCvArr; idx0: Integer; var value: double); cdecl;
procedure cvSetReal2D(arr: pCvArr; idx0, idx1: Integer; var value: double); cdecl;
procedure cvSetReal3D(arr: pCvArr; idx0, idx1, idx2: Integer; var value: double); cdecl;
procedure cvSetRealND(arr: pCvArr; idx: pInteger; var value: double); cdecl;

{ clears element of ND dense array,
  in case of sparse arrays it deletes the specified node */
  CVAPI(void) cvClearND( pCvArr* arr, const int* idx );
}
procedure cvClearND(arr: pCvArr; idx: pInteger); cdecl;

{ Converts pCvArr (IplImage or CvMat,...) to CvMat.
  If the last parameter is non-zero, function can
  convert multi(>2)-dimensional array to CvMat as long as
  the last array's dimension is continous. The resultant
  matrix will be have appropriate (a huge) number of rows */
  CVAPI(CvMat*) cvGetMat( const pCvArr* arr, CvMat* header,
                       int* coi CV_DEFAULT(NULL),
                       int allowND CV_DEFAULT(0));
}
function cvGetMat(const arr: pCvArr; header: pCvMat; coi: pInteger = nil; allowND: integer = 0): pCvMat; cdecl;

{ Converts pCvArr (IplImage or CvMat) to IplImage
  CVAPI(IplImage*) cvGetImage( const pCvArr* arr, IplImage* image_header );
}
function cvGetImage(const arr: pCvArr; image_header: pIplImage): pIplImage; cdecl;

{ Changes a shape of multi-dimensional array.
  new_cn == 0 means that number of channels remains unchanged.
  new_dims == 0 means that number and sizes of dimensions remain the same
  (unless they need to be changed to set the new number of channels)
  if new_dims == 1, there is no need to specify new dimension sizes
  The resultant configuration should be achievable w/o data copying.
  If the resultant array is sparse, CvSparseMat header should be passed
  to the function else if the result is 1 or 2 dimensional,
  CvMat header should be passed to the function
  else CvMatND header should be passed */
  CVAPI(pCvArr*) cvReshapeMatND( const pCvArr* arr,
                             int sizeof_header, pCvArr* header,
                             int new_cn, int new_dims, int* new_sizes );
  #define cvReshapeND( arr, header, new_cn, new_dims, new_sizes )   \
      cvReshapeMatND( (arr), sizeof(*(header)), (header),         \
                      (new_cn), (new_dims), (new_sizes))
}
function cvReshapeMatND(const arr: pCvArr; sizeof_header: integer; header: pCvArr;
                        new_cn, new_dims: integer; new_sizes: pInteger): pCvArr; cdecl;
function cvReshapeND(const arr: pCvArr; sizeof_header: integer; header: pCvArr;
                        new_cn, new_dims: integer; new_sizes: pInteger): pCvArr; inline;

{ CVAPI(CvMat*) cvReshape( const pCvArr* arr, CvMat* header,
                        int new_cn, int new_rows CV_DEFAULT(0) );
}
function cvReshape(const arr: pCvArr; header: pCvMat; new_cn: integer; new_rows: integer = 0): pCvMat; cdecl;

{ Repeats source 2d array several times in both horizontal and
  vertical direction to fill destination array
  CVAPI(void) cvRepeat( const pCvArr* src, pCvArr* dst );
}
procedure cvRepeat(src, dst: pCvArr); cdecl;

{ Allocates array data
  CVAPI(void)  cvCreateData( pCvArr* arr );
}
procedure cvCreateData(arr: pCvArr); cdecl;

{ Releases array data
  CVAPI(void)  cvReleaseData( pCvArr* arr );
}
procedure cvReleaseData(arr: pCvArr); cdecl;

{ Attaches user data to the array header. The step is reffered to
  the pre-last dimension. That is, all the planes of the array
  must be joint (w/o gaps) */
  CVAPI(void)  cvSetData( pCvArr* arr, void* data, int step );
}
procedure cvSetData(arr: pCvArr; data: Pointer; step: integer); cdecl;

{ Retrieves raw data of CvMat, IplImage or CvMatND.
  In the latter case the function raises an error if
  the array can not be represented as a matrix */
  CVAPI(void) cvGetRawData( const pCvArr* arr, uchar** data,
                         int* step CV_DEFAULT(NULL),
                         CvSize* roi_size CV_DEFAULT(NULL));
}
procedure cvGetRawData(arr: pCvArr; data: puchar; step: pInteger = nil; roi_size: pCvSize = nil); cdecl;

{ Returns width and height of array in elements
  CVAPI(CvSize) cvGetSize( const pCvArr* arr );
}
function cvGetSize(const arr: pCvArr): TCvSize;
procedure _cvGetSize(const arr: pCvArr; var size: TCvSize); cdecl;

{ Copies source array to destination array */
  CVAPI(void)  cvCopy( const pCvArr* src, pCvArr* dst,
                     const pCvArr* mask CV_DEFAULT(NULL) );
}
procedure cvCopy(const src: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl;

{ Sets all or "masked" elements of input array
  to the same value
  CVAPI(void)  cvSet( pCvArr* arr, CvScalar value,
                    const pCvArr* mask CV_DEFAULT(NULL) );
}
procedure cvSet(arr: pCvArr; value: TCvScalar; const mask: pCvArr = nil); cdecl; overload;
procedure cvSet(mat: pCvMat; i, j: Integer; val: Single); inline; overload;

{ Clears all the array elements (sets them to 0)
  CVAPI(void)  cvSetZero( pCvArr* arr );
  #define cvZero  cvSetZero
}
procedure cvSetZero(arr: pCvArr); cdecl;
procedure cvZero(arr: pCvArr); cdecl;

{ Splits a multi-channel array into the set of single-channel arrays or
  extracts particular [color] plane */
  CVAPI(void)  cvSplit( const pCvArr* src, pCvArr* dst0, pCvArr* dst1,
                      pCvArr* dst2, pCvArr* dst3 );
}
procedure cvSplit(const src: pIplImage; dst0: pIplImage; dst1: pIplImage;
                  dst2: pIplImage; dst3: pIplImage); cdecl;

{ Merges a set of single-channel arrays into the single multi-channel array
  or inserts one particular [color] plane to the array */
  CVAPI(void)  cvMerge( const pCvArr* src0, const pCvArr* src1,
                      const pCvArr* src2, const pCvArr* src3,
                      pCvArr* dst );
}
procedure cvMerge(const src0: pIplImage; const src1: pIplImage; const src2: pIplImage;
                  const src3: pIplImage; dst: pIplImage); cdecl;

{ Copies several channels from input arrays to
  certain channels of output arrays */
  CVAPI(void)  cvMixChannels( const pCvArr** src, int src_count,
                            pCvArr** dst, int dst_count,
                            const int* from_to, int pair_count );
}
procedure cvMixChannels(src: Array of pCvArr; src_count: integer; dst: Array of pCvArr;
                        dst_count: integer; const from_to: pInteger; pair_count: integer); cdecl;

{ Performs linear transformation on every source array element:
  dst(x,y,c) = scale*src(x,y,c)+shift.
  Arbitrary combination of input and output array depths are allowed
  (number of channels must be the same), thus the function can be used
  for type conversion
  CVAPI(void)  cvConvertScale( const pCvArr* src, pCvArr* dst,
                             double scale CV_DEFAULT(1),
                             double shift CV_DEFAULT(0) );
  #define cvCvtScale cvConvertScale
  #define cvScale  cvConvertScale
  #define cvConvert( src, dst )  cvConvertScale( (src), (dst), 1, 0 )
}
procedure cvConvertScale(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl;
procedure cvCvtScale(const src: pCvArr; dst: pCvArr; scale: Double = 1; shift: Double = 0); cdecl;
procedure cvConvert(const src: pCvArr; dst: pCvArr); inline;

{ Performs linear transformation on every source array element,
  stores absolute value of the result:
  dst(x,y,c) = abs(scale*src(x,y,c)+shift).
  destination array must have 8u type.
  In other cases one may use cvConvertScale + cvAbsDiffS */
  CVAPI(void)  cvConvertScaleAbs( const pCvArr* src, pCvArr* dst,
                                double scale CV_DEFAULT(1),
                                double shift CV_DEFAULT(0) );
  #define cvCvtScaleAbs  cvConvertScaleAbs
}
procedure cvConvertScaleAbs(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl;

{ checks termination criteria validity and
  sets eps to default_eps (if it is not set),
  max_iter to default_max_iters (if it is not set)
  CVAPI(CvTermCriteria) cvCheckTermCriteria( CvTermCriteria criteria,
                                           double default_eps,
                                           int default_max_iters );
}
function cvCheckTermCriteria(criteria: TCvTermCriteria; default_eps: double; default_max_iters: integer): TCvTermCriteria; cdecl;

//***************************************************************************************
//*                   Arithmetic, logic and comparison operations                       *
//***************************************************************************************

{ dst(mask) = src1(mask) + src2(mask)
  CVAPI(void)  cvAdd( const pCvArr* src1, const pCvArr* src2, pCvArr* dst,
                    const pCvArr* mask CV_DEFAULT(NULL));
}
procedure cvAdd(const src1, src2: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl;

{ dst(mask) = src(mask) + value
  CVAPI(void)  cvAddS( const pCvArr* src, CvScalar value, pCvArr* dst,
                     const pCvArr* mask CV_DEFAULT(NULL));
}
procedure cvAddS(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pIplImage = nil); cdecl;

{ dst(mask) = src1(mask) - src2(mask)
  CVAPI(void)  cvSub( const pCvArr* src1, const pCvArr* src2, pCvArr* dst,
                    const pCvArr* mask CV_DEFAULT(NULL));
}
procedure cvSub(const src1, src2: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl;

// dst(mask) = src(mask) - value = src(mask) + (-value)
//CV_INLINE  void  cvSubS( const pCvArr* src, CvScalar value, pCvArr* dst,
//                         const pCvArr* mask CV_DEFAULT(NULL))
//{
//    cvAddS( src, cvScalar( -value.val[0], -value.val[1], -value.val[2], -value.val[3]),
//            dst, mask );
//}
procedure cvSubS(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pIplImage = nil); inline;

{ dst(mask) = value - src(mask)
CVAPI(void)  cvSubRS( const pCvArr* src, CvScalar value, pCvArr* dst,
                      const pCvArr* mask CV_DEFAULT(NULL));
}
procedure cvSubRS(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pIplImage = nil); cdecl;

{ dst(idx) = src1(idx) * src2(idx) * scale
  (scaled element-wise multiplication of 2 arrays) */
  CVAPI(void)  cvMul( const pCvArr* src1, const pCvArr* src2,
                    pCvArr* dst, double scale CV_DEFAULT(1) );
}
procedure cvMul(const src1, src2: pIplImage; dst: pIplImage; scale: double = 1); cdecl;

{ element-wise division/inversion with scaling:
  dst(idx) = src1(idx) * scale / src2(idx)
  or dst(idx) = scale / src2(idx) if src1 == 0 */
  CVAPI(void)  cvDiv( const pCvArr* src1, const pCvArr* src2,
                    pCvArr* dst, double scale CV_DEFAULT(1));
}
procedure cvDiv(const src1, src2: pIplImage; dst: pIplImage; scale: double = 1); cdecl;

{ dst = src1 * scale + src2
  CVAPI(void)  cvScaleAdd( const pCvArr* src1, CvScalar scale,
                         const pCvArr* src2, pCvArr* dst );
  #define cvAXPY( A, real_scalar, B, C ) cvScaleAdd(A, cvRealScalar(real_scalar), B, C)
}
procedure cvScaleAdd(const src1: pIplImage; scale: TCvScalar; const src2: pIplImage; dst: pIplImage); cdecl;
procedure cvAXPY(A: pIplImage; real_scalar: double; B,C: pIplImage); inline;

{ dst = src1 * alpha + src2 * beta + gamma
  CVAPI(void)  cvAddWeighted( const pCvArr* src1, double alpha,
                            const pCvArr* src2, double beta,
                            double gamma, pCvArr* dst );
}
procedure cvAddWeighted(const src1: pIplImage; alpha: double;
                    const src2: pIplImage; beta: double;
                    gamma: double; dst: pIplImage); cdecl;

{ result = sum_i(src1(i) * src2(i)) (results for all channels are accumulated together)
  CVAPI(double)  cvDotProduct( const pCvArr* src1, const pCvArr* src2 );
}
function cvDotProduct(const src1, src2: pCvArr): double; cdecl;

{ dst(idx) = src1(idx) & src2(idx)
  CVAPI(void) cvAnd( const pCvArr* src1, const pCvArr* src2,
                  pCvArr* dst, const pCvArr* mask CV_DEFAULT(NULL));
}
procedure cvAnd(const src1: pIplImage; const src2: pIplImage;
                dst: pIplImage; masl: pIplImage = nil); cdecl;


// dst(x,y,c) = abs(src1(x,y,c) - src2(x,y,c))
// CVAPI(void) cvAbsDiff( const pCvArr* src1, const pCvArr* src2, pCvArr* dst );
procedure cvAbsDiff(const src1: pCvArr; const src2: pCvArr; dst: pCvArr); cdecl;


function cvGet(const mat: pCvMat; i, j: Integer): Single; inline;
procedure cvCopyImage(const src: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl;
procedure cvCvtPixToPlane(const src: pIplImage; dst0: pIplImage; dst1: pIplImage;
                          dst2: pIplImage; dst3: pIplImage); cdecl;
procedure cvCvtPlaneToPix(const src0: pIplImage; const src1: pIplImage;
                          const src2: pIplImage; const src3: pIplImage; dst: pIplImage); cdecl;

{ dst(idx) = src(idx) ^ value
  CVAPI(void) cvXorS( const pCvArr* src, CvScalar value, pCvArr* dst, const pCvArr* mask CV_DEFAULT(NULL));
}
procedure cvXorS(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pCvArr = nil); cdecl;

{ dst(idx) = lower(idx) <= src(idx) < upper(idx)
  CVAPI(void) cvInRange( const pCvArr* src, const pCvArr* lower, const pCvArr* upper, pCvArr* dst );
}
procedure cvInRange(const src: pIplImage; const lower: pIplImage;
                    const upper: pIplImage; dst: pIplImage); cdecl;

{ dst(idx) = lower <= src(idx) < upper
  CVAPI(void) cvInRangeS( const pCvArr* src, CvScalar lower, CvScalar upper, pCvArr* dst );
}
procedure cvInRangeS(const src: pIplImage; lower: TCvScalar;
                      upper: TCvScalar; dst: pIplImage); cdecl;

// (* ***************************************************************************************\
// *                                Math operations                                         *
// *************************************************************************************** *)

// (* Mirror array data around horizontal (flip=0),
// vertical (flip=1) or both(flip=-1) axises:
// cvFlip(src) flips images vertically and sequences horizontally (inplace) *)
// procedure cvFlip(v1: 0); var Performs Singular value Decomposition of A Matrix * )

procedure cvFlip(const src: pCvArr; dst: pCvArr = nil; flip_mode: Integer = 0); cdecl;

const
  // * types of array norm */
  CV_C = 1;
  CV_L1 = 2;
  CV_L2 = 4;
  CV_NORM_MASK = 7;
  CV_RELATIVE = 8;
  CV_DIFF = 16;
  CV_MINMAX = 32;

  CV_DIFF_C = (CV_DIFF or CV_C);
  CV_DIFF_L1 = (CV_DIFF or CV_L1);
  CV_DIFF_L2 = (CV_DIFF or CV_L2);
  CV_RELATIVE_C = (CV_RELATIVE or CV_C);
  CV_RELATIVE_L1 = (CV_RELATIVE or CV_L1);
  CV_RELATIVE_L2 = (CV_RELATIVE or CV_L2);

  // * Finds norm, difference norm or relative difference norm for an array (or two arrays) */
  // CVAPI(double)  cvNorm( const pCvArr* arr1, const pCvArr* arr2 CV_DEFAULT(NULL),
  // int norm_type CV_DEFAULT(CV_L2),
  // const pCvArr* mask CV_DEFAULT(NULL) );
function cvNorm(const arr1: pCvArr; const arr2: pCvArr = nil; norm_type: Integer = CV_L2; const mask: pCvArr = nil): Double; cdecl;


// (* ***************************************************************************************\
// *                                    cArray Statistics                                    *
// *************************************************************************************** *)

{ Calculates number of non-zero pixels
  CVAPI(Integer)cvCountNonZero(pCvArr * arr);
}
function cvCountNonZero(arr: pIplImage): Integer; cdecl;

{ Finds global minimum, maximum and their positions
  CVAPI(void)  cvMinMaxLoc(const pCvArr* arr, double* min_val, double* max_val, CvPoint* min_loc CV_DEFAULT(NULL), CvPoint* max_loc CV_DEFAULT(NULL), const pCvArr* mask CV_DEFAULT(NULL) );
}
procedure cvMinMaxLoc(const arr: pIplImage; min_val: pDouble;
                      max_val: pDouble; min_loc: pCVPoint = nil;
                      max_loc: pCVPoint = nil; const mask: pIplImage = nil); cdecl;

// ****************************************************************************************
// *                              Dynamic data structures                                 *
// ****************************************************************************************

{ Creates new memory storage.
   block_size == 0 means that default,
   somewhat optimal size, is used (currently, it is 64K)
   CVAPI(CvMemStorage*)  cvCreateMemStorage( int block_size CV_DEFAULT(0));
}
function cvCreateMemStorage(block_size: integer = 0): pCvMemStorage; cdecl;

{ Creates a memory storage that will borrow memory blocks from parent storage
  CVAPI(CvMemStorage*)  cvCreateChildMemStorage( CvMemStorage* parent );
}
function cvCreateChildMemStorage(block_size: integer = 0): pCvMemStorage; cdecl;

{ Releases memory storage. All the children of a parent must be released before
  the parent. A child storage returns all the blocks to parent when it is released
  CVAPI(void)  cvReleaseMemStorage( CvMemStorage** storage );
}
procedure cvReleaseMemStorage(var storage: pCvMemStorage); cdecl;

{ Clears memory storage. This is the only way(!!!) (besides cvRestoreMemStoragePos)
  to reuse memory allocated for the storage - cvClearSeq,cvClearSet ...
  do not free any memory.
  A child storage returns all the blocks to the parent when it is cleared
  CVAPI(void)  cvClearMemStorage( CvMemStorage* storage );
}
procedure cvClearMemStorage(storage: pCvMemStorage); cdecl;

{ Creates new empty sequence that will reside in the specified storage
  CVAPI(CvSeq*)  cvCreateSeq( int seq_flags, size_t header_size,
  size_t elem_size, CvMemStorage* storage );
}
function cvCreateSeq(seq_flags: Integer; header_size: size_t; elem_size: size_t; storage: pCvMemStorage): pCvSeq; cdecl;

// Removes specified sequence element
// CVAPI(void)  cvSeqRemove( CvSeq* seq, int index );
procedure cvSeqRemove(seq: pCvSeq; index: Integer); cdecl; 

// or cvRestoreMemStoragePos is called
// CVAPI(void)  cvClearSeq( CvSeq* seq );
procedure cvClearSeq(seq: pCvSeq); cdecl;

{ Adds new element to the end of sequence. Returns pointer to the element
  CVAPI(schar*)  cvSeqPush( CvSeq* seq, const void* element CV_DEFAULT(NULL));
}
function cvSeqPush(seq: pCvSeq; const element: Pointer = nil): Pointer; cdecl;

{ Retrieves pointer to specified sequence element.
  Negative indices are supported and mean counting from the end
  (e.g -1 means the last sequence element)
  CVAPI(schar*)  cvGetSeqElem( const CvSeq* seq, int index );
}
function cvGetSeqElem(const seq: pCvSeq; index: Integer): Pointer; cdecl;

{ Initializes sequence reader.
  The sequence can be read in forward or backward direction
  CVAPI(void) cvStartReadSeq( const CvSeq* seq, CvSeqReader* reader, int reverse CV_DEFAULT(0) );
}
procedure cvStartReadSeq(const seq: Pointer; reader: pCvSeqReader; reverse: Integer = 0); cdecl;


{ Copies sequence content to a continuous piece of memory
  CVAPI(void*)  cvCvtSeqToArray( const CvSeq* seq, void* elements, CvSlice slice CV_DEFAULT(CV_WHOLE_SEQ));
}
procedure cvCvtSeqToArray(const seq: pCvSeq; elements: pCvArr; slice: TCvSlice); cdecl;

// ************ Internal sequence functions ************/

// CVAPI(void)  cvChangeSeqBlock( void* reader, int direction );
procedure cvChangeSeqBlock(reader: pCvSeqReader; direction: Integer); cdecl;
// CVAPI(void)  cvCreateSeqBlock( CvSeqWriter* writer );
procedure cvCreateSeqBlock(writer: pCvSeqWriter); cdecl;

// writes instance of a standard type (matrix, image, sequence, graph etc.)
// or user-defined type */
// CVAPI(void) cvWrite( CvFileStorage* fs, const char* name, const void* ptr,
// CvAttrList attributes CV_DEFAULT(cvAttrList()));
procedure cvWrite(fs: pCvFileStorage; const name: pCVChar; const ptr: Pointer;
  attributes: TCvAttrList { = cvAttrList() } ); cdecl; 

type
  TCvCmpFunc = function(const a: Pointer; const b: Pointer; userdata: Pointer): Integer; cdecl; 

function cvSeqPartition(const seq: pCvSeq; storage: pCvMemStorage; labels: pCvSeq; is_equal: TCvCmpFunc;
  userdata: Pointer): Integer; cdecl; 

// ****************************************************************************************
// *                                     Drawing                                          *
// ****************************************************************************************

// Following declaration is a macro definition!
function CV_RGB(const r, g, B: double): TCvScalar; inline;

const
  CV_FILLED = -1;
  {$EXTERNALSYM CV_FILLED}

  CV_AA = 16;
  {$EXTERNALSYM CV_AA}

{ procedure cvLine(8: v1: ); shift CV_DEFAULT(0): Integer): Integer;
  CVAPI(void)  cvLine( pCvArr* img, CvPoint pt1, CvPoint pt2,
  CvScalar color, int thickness CV_DEFAULT(1),
  int line_type CV_DEFAULT(8), int shift CV_DEFAULT(0) );
}
procedure cvLine(img: pCvArr; pt1, pt2: TCvPoint; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl;

{ Draws a rectangle specified by a CvRect structure
  procedure cvRectangleR(8: v1: ); shift CV_DEFAULT(0): Integer): Integer;
}
procedure cvRectangle(img: pCvArr; pt1: TCvPoint; pt2: TCvPoint;
                          color: TCvScalar; thickness: integer = 1;
                          line_type: integer = 8;
                          shift: integer = 0); cdecl;

{ Draws a circle with specified center and radius.
  Thickness works in the same way as with cvRectangle
  CVAPI(void)  cvCircle( pCvArr* img, CvPoint center, int radius,
  CvScalar color, int thickness CV_DEFAULT(1), int line_type CV_DEFAULT(8), int shift CV_DEFAULT(0));
}
procedure cvCircle(img: pCvArr; center: TCvPoint; radius: Integer; color: TCvScalar; thickness: Integer = 1;
   line_type: Integer = 8; shift: Integer = 0); cdecl;

{ Draws ellipse outline, filled ellipse, elliptic arc or filled elliptic sector,
  depending on <thickness>, <start_angle> and <end_angle> parameters. The resultant figure
  is rotated by <angle>. All the angles are in degrees
  CVAPI(void)  cvEllipse( pCvArr* img, CvPoint center, CvSize axes,
  double angle, double start_angle, double end_angle,
  CvScalar color, int thickness CV_DEFAULT(1),
  int line_type CV_DEFAULT(8), int shift CV_DEFAULT(0));
}
procedure cvEllipse(img: pIplImage; center: TCvPoint; axes: TCvSize; angle: Double; start_angle: Double;
  nd_angle: Double; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl;

{ CV_INLINE  void  cvEllipseBox( pCvArr* img, CvBox2D box, CvScalar color,
  int thickness CV_DEFAULT(1),
  int line_type CV_DEFAULT(8), int shift CV_DEFAULT(0) )
  {
  CvSize axes;
  axes.width = cvRound(box.size.width*0.5);
  axes.height = cvRound(box.size.height*0.5);
  cvEllipse( img, cvPointFrom32f( box.center ), axes, box.angle,
  0, 360, color, thickness, line_type, shift );
}
procedure cvEllipseBox(img: pIplImage; box: TCvBox2D; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8;
  shift: Integer = 0); inline;

{ Fills convex or monotonous polygon.
 CVAPI(void)  cvFillConvexPoly( pCvArr* img, const CvPoint* pts, int npts, CvScalar color,
 int line_type CV_DEFAULT(8), int shift CV_DEFAULT(0));
}
procedure cvFillConvexPoly(img: pIplImage; const pts: pCVPoint; npts: Integer; color: TCvScalar; line_type: Integer = 8;
  shift: Integer = 0); cdecl;

{ Draws one or more polygonal curves
  CVAPI(void)  cvPolyLine( pCvArr* img, CvPoint** pts, const int* npts, int contours,
  int is_closed, CvScalar color, int thickness CV_DEFAULT(1),
  int line_type CV_DEFAULT(8), int shift CV_DEFAULT(0) );
}
procedure cvPolyLine(img: pIplImage; pts: pCVPoint; const npts: pInteger; contours: Integer; is_closed: Integer;
  color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl;

{ basic font types }
const
  CV_FONT_HERSHEY_SIMPLEX = 0;
{$EXTERNALSYM CV_FONT_HERSHEY_SIMPLEX}
  CV_FONT_HERSHEY_PLAIN = 1;
{$EXTERNALSYM CV_FONT_HERSHEY_PLAIN}
  CV_FONT_HERSHEY_DUPLEX = 2;
{$EXTERNALSYM CV_FONT_HERSHEY_DUPLEX}
  CV_FONT_HERSHEY_COMPLEX = 3;
{$EXTERNALSYM CV_FONT_HERSHEY_COMPLEX}
  CV_FONT_HERSHEY_TRIPLEX = 4;
{$EXTERNALSYM CV_FONT_HERSHEY_TRIPLEX}
  CV_FONT_HERSHEY_COMPLEX_SMALL = 5;
{$EXTERNALSYM CV_FONT_HERSHEY_COMPLEX_SMALL}
  CV_FONT_HERSHEY_SCRIPT_SIMPLEX = 6;
{$EXTERNALSYM CV_FONT_HERSHEY_SCRIPT_SIMPLEX}
  CV_FONT_HERSHEY_SCRIPT_COMPLEX = 7;
{$EXTERNALSYM CV_FONT_HERSHEY_SCRIPT_COMPLEX}
{ font flags }
  CV_FONT_ITALIC = 16;
{$EXTERNALSYM CV_FONT_ITALIC}
  CV_FONT_VECTOR0 = CV_FONT_HERSHEY_SIMPLEX;
{$EXTERNALSYM CV_FONT_VECTOR0}

{ Font structure }
type
  pCvFont = ^TCvFont;
  TCvFont = packed record
    nameFont: pCVChar;
    color: TCvScalar;
    font_face: Integer;
    ascii: pInteger;
    greek: pInteger;
    cyrillic: pInteger;
    hscale, vscale: Single;
    shear: Single;
    thickness: Integer;
    dx: Single;
    line_type: Integer;
  end;

{ Initializes font structure used further in cvPutText
  CVAPI(void) cvInitFont(CvFont* font, int font_face,
    double hscale, double vscale, double shear CV_DEFAULT(0),
    int thickness CV_DEFAULT(1), int line_type CV_DEFAULT(8));
}
procedure cvInitFont(font: pCvFont; font_face: Integer; hscale: double;
                      vscale: double; shear: double = 0; thickness: Integer = 1;
                      line_type: Integer = 8); cdecl;

{ CVAPI(void)  cvPutText( pCvArr* img, const char* text, CvPoint org,
  const CvFont* font, CvScalar color );
}
procedure cvPutText(img: pCvArr; const text: pCVChar; org: TCvPoint; const font: pCvFont; color: TCvScalar); cdecl;

{ Draws contour outlines or filled interiors on the image
CVAPI(void)  cvDrawContours( pCvArr *img, CvSeq* contour,
                             CvScalar external_color, CvScalar hole_color,
                             int max_level, int thickness CV_DEFAULT(1),
                             int line_type CV_DEFAULT(8),
                             CvPoint offset CV_DEFAULT(cvPoint(0,0)));
}
procedure cvDrawContours(img: PIplImage; contour: pCvSeq;
                          external_color,hole_color: TCvScalar;
                          max_level,thickness,line_type: integer;
                          offset: TCvPoint); cdecl;

// ****************************************************************************************
// *                                    Data Persistence                                  *
// ****************************************************************************************
// ********************************* High-level functions *********************************

{ opens existing or creates new file storage
  CVAPI(CvFileStorage*)  cvOpenFileStorage( const char* filename, CvMemStorage* memstorage,
  int flags, const char* encoding CV_DEFAULT(NULL) );
}
function cvOpenFileStorage(const filename: pCVChar; memstorage: pCvMemStorage; flags: Integer;
  const encoding: pCVChar = nil): pCvFileStorage; cdecl;

{ closes file storage and deallocates buffers
  CVAPI(void) cvReleaseFileStorage( CvFileStorage** fs );
}
procedure cvReleaseFileStorage(Var fs: pCvFileStorage); cdecl;

{ this is a slower version of cvGetFileNode that takes the key as a literal string
  CVAPI(CvFileNode*) cvGetFileNodeByName( const CvFileStorage* fs,
  const CvFileNode* map, const char* name );
}
function cvGetFileNodeByName(const fs: pCvFileStorage; const map: pCvFileNode; const name: pCVChar): pCvFileNode; cdecl;

{ CV_INLINE int cvReadInt( const CvFileNode* node, int default_value CV_DEFAULT(0) )
  return !node ? default_value :
  CV_NODE_IS_INT(node->tag) ? node->data.i :
  CV_NODE_IS_REAL(node->tag) ? cvRound(node->data.f) : 0x7fffffff;
}
function cvReadInt(const node: pCvFileNode; default_value: Integer = 0): Integer; inline;

{ CV_INLINE int cvReadIntByName( const CvFileStorage* fs, const CvFileNode* map,
  const char* name, int default_value CV_DEFAULT(0) )
  {
  return cvReadInt( cvGetFileNodeByName( fs, map, name ), default_value );
}
function cvReadIntByName(const fs: pCvFileStorage; const map: pCvFileNode; const name: pCVChar;
  default_value: Integer = 0): Integer; inline;

{ decodes standard or user-defined object and returns it
  CVAPI(void*) cvRead( CvFileStorage* fs, CvFileNode* node,
  CvAttrList* attributes CV_DEFAULT(NULL));
}
function cvRead(fs: pCvFileStorage; node: pCvFileNode; attributes: pCvAttrList = nil): pPointer; cdecl;

//*********************************** Adding own types ***********************************/

// * universal functions */
// CVAPI(void) cvRelease( void** struct_ptr );
procedure cvRelease(var struct_ptr: Pointer); cdecl; overload;
procedure cvRelease(var struct_ptr: pCvSeq); cdecl; overload;

{ simple API for reading/writing data
  CVAPI(void) cvSave( const char* filename,
  const void* struct_ptr,
  const char* name CV_DEFAULT(NULL),
  const char* comment CV_DEFAULT(NULL),
  CvAttrList attributes CV_DEFAULT(cvAttrList()));
  CVAPI(void*) cvLoad( const char* filename,
  CvMemStorage* memstorage CV_DEFAULT(NULL),
  const char* name CV_DEFAULT(NULL),
  const char** real_name CV_DEFAULT(NULL) );
}

procedure cvSave(const filename: pCVChar; const struct_ptr: Pointer; const name: pCVChar; const comment: pCVChar;
  attributes: TCvAttrList); cdecl; overload;
procedure cvSave(const filename: pCVChar; const struct_ptr: Pointer; const name: pCVChar = Nil;
  const comment: pCVChar = Nil); overload; inline;
function cvLoad(const filename: pCVChar; memstorage: pCvMemStorage = Nil; const name: pCVChar = nil;
  const real_name: ppChar = nil): Pointer; cdecl;

//*********************************** Measuring Execution Time ***************************/

{ helper functions for RNG initialization and accurate time measurement:
  uses internal clock counter on x86 }
function cvGetTickCount: int64; inline;
function cvGetTickFrequency: Double;

// *********************************** CPU capabilities ***********************************/
// CVAPI(int) cvCheckHardwareSupport(int feature);
function cvCheckHardwareSupport(feature: Integer): Integer; cdecl;

// *********************************** Multi-Threading ************************************/

// * retrieve/set the number of threads used in OpenMP implementations */
// CVAPI(int)  cvGetNumThreads( void );
function cvGetNumThreads: Integer; cdecl;
// CVAPI(void) cvSetNumThreads( int threads CV_DEFAULT(0) );
procedure cvSetNumThreads(threads: Integer = 0); cdecl;
// * get index of the thread being executed */
// CVAPI(int)  cvGetThreadNum( void );
function cvGetThreadNum: Integer; cdecl; 

const
  CV_CPU_NONE = 0;
  CV_CPU_MMX = 1;
  CV_CPU_SSE = 2;
  CV_CPU_SSE2 = 3;
  CV_CPU_SSE3 = 4;
  CV_CPU_SSSE3 = 5;
  CV_CPU_SSE4_1 = 6;
  CV_CPU_SSE4_2 = 7;
  CV_CPU_POPCNT = 8;
  CV_CPU_AVX = 10;
  CV_HARDWARE_MAX_FEATURE = 255;

implementation

uses ulibname;

function cvCreateImageHeader; external Core_Dll;
function cvInitImageHeader; external Core_Dll;
function cvCreateImage; external Core_Dll;
procedure cvReleaseImageHeader; external Core_Dll;
procedure cvReleaseImage; external Core_Dll;
function cvCloneImage; external Core_Dll;
procedure cvSetImageCOI; external Core_Dll;
function cvGetImageCOI; external Core_Dll;
procedure cvSetImageROI; external Core_Dll;
procedure cvResetImageROI; external Core_Dll;
function cvGetImageROI; external Core_Dll;
function cvCreateMatHeader; external Core_Dll;
function cvInitMatHeader; external Core_Dll;
function cvCreateMat; external Core_Dll;
procedure cvReleaseMat; external Core_Dll;
function cvCloneMat; external Core_Dll;
function cvGetSubRect; external Core_Dll;
procedure cvGetSubArr; external Core_Dll name 'cvGetSubRect';

function cvGetRow(const arr: pCvArr; submat: pCvMat; row: integer): pCvMat;
begin
  Result := cvGetRows(arr, submat, row, row+1, 1);
end;

function cvGetCols; external Core_Dll;

function cvGetCol(const arr: pCvArr; submat: pCvMat; col: integer): pCvMat;
begin
  Result := cvGetCols(arr, submat, col, col+1);
end;

function cvGetDiag; external Core_Dll;
procedure cvScalarToRawData; external Core_Dll;
procedure cvRawDataToScalar; external Core_Dll;
function cvCreateMatNDHeader; external Core_Dll;
function cvCreateMatND; external Core_Dll;
function cvInitMatNDHeader; external Core_Dll;

procedure cvReleaseMatND(var mat: pCvMatND); inline;
begin
  cvReleaseMat(pCvMat(mat));
end;

function cvCloneMatND; external Core_Dll;
function cvCreateSparseMat; external Core_Dll;
procedure cvReleaseSparseMat; external Core_Dll;
function cvCloneSparseMat; external Core_Dll;
function cvInitSparseMatIterator; external Core_Dll;

// returns next sparse array node (or NULL if there is no more nodes)
//CV_INLINE CvSparseNode* cvGetNextSparseNode( CvSparseMatIterator* mat_iterator )
//{
//    if( mat_iterator->node->next )
//        return mat_iterator->node = mat_iterator->node->next;
//    else
//    {
//        int idx;
//        for( idx = ++mat_iterator->curidx; idx < mat_iterator->mat->hashsize; idx++ )
//        {
//            CvSparseNode* node = (CvSparseNode*)mat_iterator->mat->hashtable[idx];
//            if( node )
//            {
//                mat_iterator->curidx = idx;
//                return mat_iterator->node = node;
//            }
//        }
//        return NULL;
//    }
//}
function cvGetNextSparseNode(mat_iterator: pCvSparseMatIterator): pCvSparseNode;
var
  idx: integer;
  node: pCvSparseNode;
begin
  if Assigned(mat_iterator.node.next) then
  begin
    mat_iterator.node := mat_iterator.node.next;
    result := mat_iterator.node;
  end
  else
  begin
    Inc(mat_iterator.curidx);
    for idx := mat_iterator.curidx to mat_iterator.mat.hashsize-1 do
    begin
      node := mat_iterator.mat.hashtable[idx];
      if Assigned(node) then
      begin
        mat_iterator.curidx := idx;
        mat_iterator.node := node;
        result := mat_iterator.node;
        exit;
      end;
    end;
    result := nil;
  end;
end;

function cvInitNArrayIterator; external Core_Dll;
function cvNextNArraySlice; external Core_Dll;
function cvGetElemType; external Core_Dll;
function cvGetDims; external Core_Dll;
function cvGetDimSize; external Core_Dll;
function cvPtr1D; external Core_Dll;
function cvPtr2D; external Core_Dll;
function cvPtr3D; external Core_Dll;
function cvPtrND; external Core_Dll;
function cvGet1D; external Core_Dll;
function cvGet2D; external Core_Dll;
function cvGet3D; external Core_Dll;
function cvGetND; external Core_Dll;
function cvGetReal1D; external Core_Dll;
function cvGetReal2D; external Core_Dll;
function cvGetReal3D; external Core_Dll;
function cvGetRealND; external Core_Dll;
procedure cvSet1D; external Core_Dll;
procedure cvSet2D; external Core_Dll;
procedure cvSet3D; external Core_Dll;
procedure cvSetND; external Core_Dll;
procedure cvSetReal1D; external Core_Dll;
procedure cvSetReal2D; external Core_Dll;
procedure cvSetReal3D; external Core_Dll;
procedure cvSetRealND; external Core_Dll;
procedure cvClearND; external Core_Dll;
function cvGetMat; external Core_Dll;
function cvGetImage; external Core_Dll;
function cvReshapeMatND; external Core_Dll;

function cvReshapeND(const arr: pCvArr; sizeof_header: integer; header: pCvArr;
                        new_cn, new_dims: integer; new_sizes: pInteger): pCvArr; inline;
begin
  Result := cvReshapeMatND(arr, sizeof(sizeof_header), header, new_cn, new_dims, new_sizes);
end;

function cvReshape; external Core_Dll;
procedure cvRepeat; external Core_Dll;
procedure cvCreateData; external Core_Dll;
procedure cvReleaseData; external Core_Dll;
procedure cvSetData; external Core_Dll;
procedure cvGetRawData; external Core_Dll;

function cvGetSize(const arr: pCvArr): TCvSize; assembler;
asm
  // mov eax,arr - � eax ��� �������� ����� arr
  push edx      // � edx ����� ���������� Result - ���������, �.�. _cvGetSize ���������� ��������� � eax:edx
  push eax
  call _cvGetSize
  pop ecx       // ������ ����
  mov ecx,edx   // ��������� ������� ����� ���������� _cvGetSize
  pop edx       // ��������������� Result
  mov Result.width,eax
  mov Result.height,ecx
end;

procedure _cvGetSize(const arr: pCvArr; var size: TCvSize); external Core_Dll name 'cvGetSize';
procedure cvCopy; external Core_Dll;
procedure cvSet(arr: pCvArr; value: TCvScalar; const mask: pCvArr = Nil); external Core_Dll;

procedure cvSet(mat: pCvMat; i, j: Integer; val: Single); inline;
var
  type_: Integer;
  ptr: PUCHAR;
  pf: PSingle;
begin
  type_ := CV_MAT_TYPE(mat._type);
  assert((i < mat^.rows) and (j < mat^.cols) and (type_ = CV_32FC1));
  ptr := mat^.data;
  inc(ptr, mat.step * i + sizeOf(Single) * j);
  pf := PSingle(ptr);
  pf^ := val;
end;

procedure cvSetZero; external Core_Dll;
procedure cvZero; external Core_Dll name 'cvSetZero';
procedure cvSplit; external Core_Dll;
procedure cvMerge; external Core_Dll;
procedure cvMixChannels; external Core_Dll;
procedure cvConvertScale; external Core_Dll;

procedure cvConvert(const src: pCvArr; dst: pCvArr); inline;
begin
  cvConvertScale(src, dst, 1, 0);
end;

procedure cvScale; external Core_Dll name 'cvConvertScale';
procedure cvCvtScale; external Core_Dll name 'cvConvertScale';
procedure cvConvertScaleAbs; external Core_Dll;
procedure cvCvtScaleAbs; external Core_Dll name 'cvConvertScaleAbs';
function cvCheckTermCriteria; external Core_Dll;
procedure cvAdd; external Core_Dll;
procedure cvAddS; external Core_Dll;
procedure cvSub; external Core_Dll;

procedure cvSubS(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pIplImage);
begin
  cvAddS(src, CvScalar(-value.val[0], -value.val[1], -value.val[2], -value.val[3]), dst, mask);
end;

procedure cvSubRS; external Core_Dll;
procedure cvMul; external Core_Dll;
procedure cvDiv; external Core_Dll;
procedure cvScaleAdd; external Core_Dll;

//define cvAXPY( A, real_scalar, B, C ) cvScaleAdd(A, cvRealScalar(real_scalar), B, C)
procedure cvAXPY(A: pIplImage; real_scalar: double; B,C: pIplImage); inline;
begin
  cvScaleAdd(A, cvRealScalar(real_scalar), B, C);
end;

procedure cvAddWeighted; external Core_Dll;
function cvDotProduct; external Core_Dll;


procedure cvAlloc(size: size_t); external Core_Dll;
procedure cvFree_(ptr: Pointer); external Core_Dll;

procedure cvInitFont; external Core_Dll;
procedure cvPutText; external Core_Dll;

procedure cvCircle; external Core_Dll;
procedure cvLine; external Core_Dll;

procedure cvCopyImage; external Core_Dll name 'cvCopy';

function CV_RGB(const r, g, B: double): TCvScalar; inline;
begin
  Result := CvScalar(B, g, r, 0);
end;

procedure cvSave(const filename: pCVChar; const struct_ptr: Pointer; const name: pCVChar; const comment: pCVChar;
  attributes: TCvAttrList); external Core_Dll; overload;

procedure cvSave(const filename: pCVChar; const struct_ptr: Pointer; const name: pCVChar = Nil;
  const comment: pCVChar = Nil); overload; inline;
begin
  cvSave(filename, struct_ptr, name, comment, ZeroCvAttrList);
end;

function cvLoad; external Core_Dll;

procedure cvInRange; external Core_Dll;
procedure cvInRangeS; external Core_Dll;
procedure cvMinMaxLoc; external Core_Dll;
procedure cvAnd; external Core_Dll;

procedure cvCvtPixToPlane; external Core_Dll name 'cvSplit';
procedure cvCvtPlaneToPix; external Core_Dll name 'cvMerge';


function cvCreateMemStorage; external Core_Dll;
function cvGetSeqElem; external Core_Dll;
procedure cvReleaseMemStorage; external Core_Dll;
procedure cvRectangle; external Core_Dll;
function cvGetRows; external Core_Dll;
procedure cvFlip; external Core_Dll;
procedure cvMirror; external Core_Dll name 'cvFlip';
procedure cvClearMemStorage; external Core_Dll;
procedure cvDrawContours; external Core_Dll;
function cvCreateChildMemStorage; external Core_Dll;
procedure cvCvtSeqToArray; external Core_Dll;

function cvOpenFileStorage; external Core_Dll;
procedure cvReleaseFileStorage; external Core_Dll;

function cvGetFileNodeByName; external Core_Dll;

function cvReadInt;
begin
  // return !node ? default_value :
  // CV_NODE_IS_INT(node->tag) ? node->data.i :
  // CV_NODE_IS_REAL(node->tag) ? cvRound(node->data.f) : 0x7fffffff;
  Result := iif(not Assigned(node), default_value, iif(CV_NODE_IS_INT(node^.tag), node^.i,
    iif(CV_NODE_IS_REAL(node^.tag), node^.f, $7FFFFFFF)));
end;

function cvReadIntByName;
begin
  // return cvReadInt( cvGetFileNodeByName( fs, map, name ), default_value );
  Result := cvReadInt(cvGetFileNodeByName(fs, map, name), default_value);
end;

function cvRead; external Core_Dll;
procedure cvStartReadSeq; external Core_Dll;
procedure cvChangeSeqBlock; external Core_Dll;
procedure cvFillConvexPoly; external Core_Dll;
procedure cvPolyLine; external Core_Dll;

function cvCreateSeq; external Core_Dll;
procedure cvCreateSeqBlock; external Core_Dll;
function cvSeqPush; external Core_Dll;

procedure cvEllipseBox;
var
  axes: TCvSize;
begin
  axes.width := cvRound(box.size.width * 0.5);
  axes.height := cvRound(box.size.height * 0.5);
  cvEllipse(img, cvPointFrom32f(box.center), axes, box.angle, 0, 360, color, thickness, line_type, shift);
end;

procedure cvXorS; external Core_Dll;
procedure cvEllipse; external Core_Dll;

procedure cvFree;
begin
  // #define cvFree(ptr) (cvFree_(*(ptr)), *(ptr)=0)
  cvFree_(@ptr);
  Pointer(ptr) := nil;
end;

function cvCountNonZero; external Core_Dll;

function cvGet(const mat: pCvMat; i, j: Integer): Single; inline;
var
  type_: Integer;
  ptr: PUCHAR;
  pf: PSingle;
begin
  type_ := CV_MAT_TYPE(mat^._type);
  assert((i < mat^.rows) and (j < mat^.cols) and (type_ = CV_32FC1));
  ptr := mat^.data;
  inc(ptr, mat.step * i + sizeOf(Single) * j);
  pf := PSingle(ptr);
  Result := pf^;
end;

procedure cvRelease(var struct_ptr: Pointer); external Core_Dll name 'cvRelease';
procedure cvRelease(var struct_ptr: pCvSeq); external Core_Dll name 'cvRelease';

function cvGetTickCount;
begin
  Result := GetTickCount;
end;

function GetTickFrequency: Double;
Var
  freq: TLargeInteger;
begin
  QueryPerformanceFrequency(freq);
  Result := freq;
end;

function cvGetTickFrequency: Double;
begin
  Result := GetTickFrequency() * 1E-6;
end;

function cvCheckHardwareSupport; external Core_Dll;
function cvGetNumThreads; external Core_Dll;
procedure cvSetNumThreads; external Core_Dll;
function cvGetThreadNum; external Core_Dll; 

procedure cvAbsDiff; external Core_Dll;
function cvNorm; external Core_Dll;

procedure cvSeqRemove; external Core_Dll;
procedure cvClearSeq; external Core_Dll;
procedure cvWrite; external Core_Dll;
function cvSeqPartition; external Core_Dll; 

end.
