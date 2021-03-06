Sudiball   ![Sudiball](https://ix.cs.uoregon.edu/~tomc/Hobbies/Astronomy/ATM/SudiBall/open_sb1t.png "Sudiball")
========

## Skeletal gimbal mount  
### It's like a ball but less.   

To play with the models yourself you will need to  
install a recent __stable__ version of OpenSCAD  
(You may need to get a recent version from <http://www.openscad.org/>)

I am focusing this software on easily built "standard" versions  
(where the planes intersect at right angles in the center of the ball).   
To facilitate visual experimentation prior to generating 2D or 3D files,   
the OpenSCAD scripts are divided into four modules.


__sudiconfig.scad__: Where you will edit parameters (use any text editor)   
__sudiview.scad__:	 Open with OpenSCAD to see changes from parameters edited & save 3D.  
__sudigen.scad__:	 Open with OpenSCAD to generate 2D parts seen in sudiview  
__sudilib.scad__:	Common routines used by both sudiview & sudigen.   

Workflow is: with all four files in the same directory:  
1.  open the _sudiconfig.scad_ file in your favorite text editor  
  (you can also use OpenSCAD as your editor but will need to switch files more  
2.  open __sudiview.scad__ in OpenSCAD and have it render (hit F5)  
3.  Edit the _sudiconfig.scad_ file to suit your needs  
4.  Hit F5 to render your changes in the OpenScad window running sudiview.scad_  
5.  Rinse and repeat the previous two steps to your hearts content  
6.  For 3D files just choose the format you want (.stl) and __Export__ it.  
7.  For 2D files of one flat sheet use __sudigen.scad__ and read instructions.  

------------------------------------------------------------------------
For more information see:
  
- My page with other ATM related
https://ix.cs.uoregon.edu/~tomc/Hobbies/Astronomy/ATM/index.html  
 
- A short informal paper
http://ix.cs.uoregon.edu/~tomc/Hobbies/Astronomy/ATM/SudiBall.pdf

- Initial set of vector files (circa 2013)  
[SVG,DXF,PDF](vector_files/)  
[Initial OpenSCAD SudiBall Template](Mark_I/sudiball_template.scad/)


------------------------------------------------------------------------
Occasional Updates with newer further down the page  
--2013 Jul

In the spirit of moving from the theoretical "you can design anything you want" 
to the more practical -- this is the simplest Sudiball to build with everyday tools and materials. 

CAD drawings and print files of my first generic Sudiball are in the [Vector Files](/vector_files/) directory. 
There are two sizes of vector drawing and four formats in the
Both are designed to use 3/4" material. 
So far, the 24" has been scaled in half and used with 3/8" material 
and to a third to use 1/4" material. 

The Postscript can be printed on paper glued to whatever and cut out for quick tests 
the DXF may need some cleanup before feeding to a machine, i.e cross-hairs removed.
The important part here is the slots are just 90 degree cuts 
and cutting the entire profile at 90 degrees does not interfere 
with making the compound curve on the runners as a separate operation. 
This means the profiles may be cut with a laser, waterjet, CNC router, milling machine 
or by hand with a router or saw.

The compound curve on the runners of a two foot diameter Sudiball with a 3/4" thick edge 
is under six thousandths of an inch, since the square edge is tangent to the sphere. 
This means just breaking the edge with sandpaper does a pretty good job of forming the desired curve.
i.e. Sticking adhesive back sandpaper to the ground ring and swirling it about is enough.



--------------------------------------------------------------------------------

--2017 March  
A couple of incremental update notes.  
First regarding a base which can be a simple ring.  
The SudiBall must contact the ring in at least three places which limits the
diameter of the supporting ring to be not smaller than
the height of the triangle formed by the intersecting runners.
(height is measured from the center of the base to the apex of an equlateral triangle)  
This give a rule of thumb of the diameter of the contact patch on
the support ring not less than 61.25% of the SudiBall diameter.

If you care where the 61.25% comes from,  
the length of a chord with 90 deg separation is:  
`2 *sin (90/ 2 ) * r`

three of those chords come together as a equilateral triangle  
the height of an equilateral triangle is  
`sin(60) * length of a side`  
since we want a precentage of a unit diameter and not of a unit radius
we can drop the leading `2 *`

`sin(45) ×sin(60)  = 0.612372436`  
`0.612372436 * 100 = 61.25%`
 
------------------------------------------------------------------------------
second note:   
It is easy to unedrestimate the lateral forces in play which to tend to distort
the ring from circular to a trifoil or warped from a plane.
Even small distortions will cause a _TIC!_ when a runner contacts the support ring broadside.

Two approaches to mitigate the _TIC!_.  
- Use a stronger ring support.  
- Ease the approach onto the support.  

The first needs whatever works, the second is geometery.  
If the support surface is flat and nearly _normal_ or _tangent_ to the curve
of the SudiBall it forms little "on ramps" whos easement is related to 
the the width of of the flat surface.  
![conic easement](Gallery/nornal_support.png)

It also allows covering the support surface with a (_replacable_)   
sheet material i.e. metal or fancy plastics cut into a strip with a [Cone Calculator](https://duckduckgo.com/?q=cone+calculator&ia=web)

With a minimal sized ring for a standard three plane SudiBall  
an off-the-shelf [45-deg rouder bit](https://duckduckgo.com/?q=45+deg+router+bit+chamfer&iax=1&ia=images)
swung in a [router compass jig](https://duckduckgo.com/?q=router+compass+jig&iar=images&iax=1&ia=images) will chamfer
a nearly normal support surface.  

------------------------------------------------------------------------------

Joining the tips of a sudiball together can be tricky if joinery is not also your day job
but by cutting interlocking fingers into the ends of the runners you get a
simple solid connection called a [fingerjoint](https://en.wikipedia.org/wiki/Finger_joint)  
![fingerjoint](Gallery/sudiball_fingerjoint.png)  
(which is especially trivial if you are using  CNC with negligible kerf)

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

If you have build a SudiBall, please do get in touch,

I have set up a [Rouges Gallery](https://ix.cs.uoregon.edu/~tomc/Hobbies/Astronomy/ATM/SudiBall/RoguesGallery/index.html) and would be happy to show or point your work.

The annotated gallery is currently set up to accept jpeg images  
along with an optional separate simple text (.txt) file per image.  
(same filenames, diferent extensions)


Email sudiball360@gmail.com for more info.
